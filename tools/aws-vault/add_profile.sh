#!/bin/zsh

set -e

add_profile=true

# If the variable is not set, 
# assign 'false' to the global variable 'add_profile'
function checkVariable()
{
    local REFERENCE=$1
    if [ -z ${(P)REFERENCE+x} ]; then
        echo "The variable $REFERENCE has not been set"
        add_profile=false
    fi
}

# chek that all necessary environment variable are set
checkVariable "AWS_ACCESS_KEY_ID"
checkVariable "AWS_SECRET_ACCESS_KEY"
checkVariable "AWS_VAULT_FILE_PASSPHRASE"

# Store AWS credentials for the "dev" profile
if [ "$add_profile" = true ]; then
    aws-vault add --debug --env dev
fi