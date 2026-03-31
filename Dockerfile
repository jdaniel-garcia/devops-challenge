FROM node:22-alpine AS builder
WORKDIR /app

RUN apk add --no-cache libc6-compat && corepack enable pnpm

COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml ./
COPY prisma ./prisma
RUN pnpm install --frozen-lockfile --ignore-scripts

COPY . .

RUN pnpm build
RUN pnpm prune --prod --ignore-scripts

FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
ENV PATH="/app/node_modules/.bin:$PATH"

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma
COPY prisma.config.ts ./

USER nextjs
EXPOSE 3000

CMD ["node", "server.js"]