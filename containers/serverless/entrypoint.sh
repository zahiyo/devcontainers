#!/bin/zsh

set -e

# Create a "dev" profile when AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_VAULT_FILE_PASSPHRASE are provided
curl -o aws-vault.add-profile.sh https://raw.githubusercontent.com/zahiyo/devcontainers/master/tools/aws-vault/add_profile.sh
chmod +x aws-vault.add-profile.sh
source aws-vault.add-profile.sh
rm aws-vault.add-profile.sh

exec /entrypoint.sh $@
