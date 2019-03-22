
To create an encrypted value for a environment variable you can:

    cat config/master.key | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --keyring runtime-secrets --key RAILS_MASTER_KEY | base64

You'll want to store the result of the above inside cloudbuild.yml's variables list.

    date | md5 | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --keyring runtime-secrets --key POSTGRES_PASSWORD | base64

This generates a pgbouncer md5 hash for userlists:

    echo "md5$(printf "ccb68a5e5e794d20269d9fe52527b065application" | openssl md5)"
