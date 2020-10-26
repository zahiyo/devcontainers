#!/bin/bash
#
# Install the AWS CLI version 2

set -eou pipefail

# Create a temporary directory
readonly TMP_DIR=$(mktemp -d -t aws-cli.XXXXXXXXXX)
cd "${TMP_DIR}"

# Download the installation file
curl -fsSL 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o "awscliv2.zip"

# Download the signature file
curl -fsSL 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig' -o "awscliv2.sig"

# Import the public key
curl -fsSL 'https://raw.githubusercontent.com/zahiyo/devcontainers/master/script-library/public-keys/aws-cli' | gpg --import

# Verify the signature
gpg --verify "awscliv2.sig" "awscliv2.zip"

# Unzip the installer
unzip -q "awscliv2.zip"

# Run the installer
./aws/install

# Smoke test
aws --version

# Clean up
rm -rf "${TMP_DIR}"
