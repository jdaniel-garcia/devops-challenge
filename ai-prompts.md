Provide minimal example of the usage of terraform-google-modules/kubernetes-engine/google

Generate a TF file to authenticate github actions in GAR using workload identity federation

Use direct login method instead of using a service account

Provide Dockerfile to build my nextjs and prisma app, include static testing. Be aware that prisma will run a migration step at run time so include
required files and binaries. Do not copy the complete node_modules folder. Keep image size at the very minimum.

Build a small helm chart to deploy my app. Include at least deployment and service of type LoadBalancer. Keep code DRY.

This is my pipeline, add now steps to:
* update image tag in values/dev.yaml, that looks like
* Push that change to the repo.
* Wait for argo to deploy the change
* Test the change is working with curl
* Repeat the operation in values/prod.yaml

