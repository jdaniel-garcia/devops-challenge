PROJECT_ID   := challenge-moonpay
ZONE       := europe-southwest1-a
CLUSTER_NAME := moonpay-cluster

.PHONY: tf-init tf-apply tf-destroy

tf-init:
	@echo "==> Init Terraform..."
	cd terraform && terraform init

tf-apply: tf-init
	@echo "==> Applying..."
	cd terraform && terraform apply -auto-approve

tf-destroy:
	@echo "==> Destroying..."
	cd terraform && terraform destroy -auto-approve

.PHONY: get-credentials

get-credentials:
	@echo "==> Acquiring credentials..."
	gcloud container clusters get-credentials $(CLUSTER_NAME) --zone $(ZONE) --project $(PROJECT_ID)

.PHONY: deploy-argocd

deploy-argocd: get-credentials
	@echo "==> Creating ArgoCD Namespace..."
	kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

	@echo "==> Creating required secrets..."
	kubectl apply -f init/argocd-secret.yaml
	kubectl apply -f init/postgres-dev.yaml
	kubectl apply -f init/postgres-prod.yaml

	@echo "==> Deploying ArgoCD..."
	cd init/argocd && helm dependency build
	cd init/argocd && helm upgrade --install argocd . --namespace argocd

.PHONY: deploy-all

deploy-all: tf-apply deploy-argocd
	@echo "==> Deployed"