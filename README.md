gcloud iam service-accounts create terraform-sa --display-name "Terraform service account"
gcloud projects add-iam-policy-binding intense-elysium-446714-g4 --member="serviceAccount:terraform-sa-na@intense-elysium-446714-g4.iam.gserviceaccount.com" --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding intense-elysium-446714-g4 --member="serviceAccount:terraform-sa-na@intense-elysium-446714-g4.iam.gserviceaccount.com" --role="roles/compute.admin"

gsutil mb -p intense-elysium-446714-g4 -l us-central1 gs://tf-state-intense-elysium-446714-g4

gsutil versioning set on gs://tf-state-intense-elysium-446714-g4

gcloud projects add-iam-policy-binding intense-elysium-446714-g4 --member="se
rviceAccount:terraform-sa-na@intense-elysium-446714-g4.iam.gserviceaccount.com"
 --role="roles/storage.admin"

 wif: https://cloud.google.com/iam/docs/workload-identity-federation-with-deployment-pipelines#github-actions_4
 https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect

 gcloud iam workload-identity-pools create "terraform-pool" \
  --project="intense-elysium-446714-g4" \
  --location="global" \
  --display-name="Terraform GitHub Pool"


gcloud iam workload-identity-pools providers create-oidc PROVIDER_ID \
    --location="global" \
    --workload-identity-pool="POOL_ID" \
    --issuer-uri="https://token.actions.githubusercontent.com/" \
    --attribute-mapping="MAPPINGS" \
    --attribute-condition="CONDITIONS"

attribute mapping is 
    google.subject=assertion.sub

Define an attribute condition
    assertion.repository_owner=='ORGANIZATION'

my github repo organization is nkarumanchi27

gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --project="intense-elysium-446714-g4" \
  --location="global" \
  --workload-identity-pool="terraform-pool" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub" \
  --attribute-condition="assertion.repository_owner=='nkarumanchi27'"

gcloud iam service-accounts add-iam-policy-binding "terraform-gcp@intense-elysium-446714-g4.iam.gserviceaccount.com"   --role="roles/iam.workloadIdentityUser"   --member="principal://iam.googleapis.com/projects/1090599615250/locations/global/workloadIdentityPools/terraform-pool/subject/nkarumanchi27"