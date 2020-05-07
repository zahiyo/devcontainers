#!/bin/sh

set -e

PUBLIC_KEY=$1

# Download the zip file
curl -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip

# Download the AWS CLI signature file
curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig

# Import the AWS CLI public key
gpg --import $PUBLIC_KEY

# Verify the signature
gpg --verify awscliv2.sig awscliv2.zip

# Unzip the installer
unzip -q awscliv2.zip

# Run the install program
chmod +x ./aws/dist/aws
./aws/install --bin-dir /aws-cli-bin/