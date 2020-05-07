#!/bin/sh

set -e

TERRAFORM_VERSION=$1
RELEASE_PUBLIC_KEY=$2

# Download Terraform zip file
curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Download Terraform checksums
curl -o terraform_checksums https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS

# Download the signature for the checksums file
curl -o terraform_checksums.sig https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig

# Import the Hashicorp release key
gpg --import $RELEASE_PUBLIC_KEY

# Verify the checksums file is signed by the key
gpg --verify terraform_checksums.sig terraform_checksums

# Verify the zip file matches the expected checksum
grep linux_amd64 terraform_checksums >terraform_linux_amd64_checksum
sha256sum -cs terraform_linux_amd64_checksum

# Extract the zip file
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin