gcr-json-keySetup so we can pull from gcloud's docker registry inside of docker for desktop:

    gcloud components install docker-credential-gcr
    docker-credential-gcr configure-docker
    gcloud iam service-accounts create docker-for-desktop --display-name "Handles all Docker for desktop services"
    gcloud projects add-iam-policy-binding poutineer --member serviceAccount:docker-for-desktop@poutineer.iam.gserviceaccount.com --role roles/iam.serviceAccountTokenCreator
    gcloud projects add-iam-policy-binding poutineer --member serviceAccount:docker-for-desktop@poutineer.iam.gserviceaccount.com --role roles/viewer

Create credentials for the gcloud service account for non-GKE development:

    gcloud iam service-accounts keys create ./tmp/gcloud-key.json --iam-account docker-for-desktop@poutineer.iam.gserviceaccount.com
    kubectl create secret docker-registry gcr-json-key --docker-server=gcr.io --docker-username=_json_key --docker-password="$(cat ./tmp/gcloud-key.json)" --docker-email=docker-for-desktop@poutineer.iam.gserviceaccount.com

Setup the Google Cloud project:

    gcloud projects create --set-as-default poutineer

Create a gcloud keyring and key for encrypting the cluster:

    gcloud kms keyrings create cluster-secrets --location global --project poutineer
    gcloud kms keys create database-encryption --location global --keyring cluster-secrets --purpose encryption --project poutineer

Setup k8s clusters:

    bin/gcloud-cluster-setup

Setup ip addresses:

    gcloud services enable compute.googleapis.com
    gcloud compute addresses create poutineer-ipv4-address --global --ip-version IPV4
    gcloud compute addresses create poutineer-ipv6-address --global --ip-version IPV6
    gcloud compute addresses list

Then point zone file to those ip addresses.

Setup GCP to handle our docker images (???):

    gcloud services enable containerregistry.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
    export COMMIT_SHA=$(git rev-parse --verify HEAD)
    gcloud container builds submit --config cloudbuild.yaml --substitutions=COMMIT_SHA=$COMMIT_SHA

Create a gcloud keyring:

    gcloud kms keyrings create runtime-secrets --location global --project poutineer

Create a gcloud key for every environment variable needing security and give various service accounts access to these keys:

    bin/gcloud-secrets-setup

To store a secret environment variable you can:

    cat config/master.key | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --location global --keyring runtime-secrets --key RAILS_MASTER_KEY | base64
    date | md5 | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --location global --keyring runtime-secrets --key POSTGRES_PASSWORD | base64

You'll want to store the result of the above inside cloudbuild's variables list.

This generates a pgbouncer md5 hash for userlists:

    echo "md5$(printf "{{password}}{{username}}" | openssl md5)"
