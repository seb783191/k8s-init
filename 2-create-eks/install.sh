#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Argument manquant: <Environnement:[cdn1|cdn2|...]> <Region AWS:[us-east-1|eu-west-3|others]>"
  exit 1
fi

export ENV=$1
export AWS_REGION=$2
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AZS=($(aws ec2 describe-availability-zones --query 'AvailabilityZones[].ZoneName' --output text --region $AWS_REGION))

# Deploy kms
export MASTER_ARN=$(aws kms describe-key --key-id alias/$ENV-eksctl --query KeyMetadata.Arn --output text)

# sed
sed -e 's|ENV|'$ENV'|; s|AWS_REGION|'$AWS_REGION'|; s|MASTER_ARN|'$MASTER_ARN'|' clusterconfig.yaml > $ENV-eksctl.yaml

# Install eks
/usr/local/bin/eksctl create cluster -f $ENV-eksctl.yaml

# # Post Install
# . ./post_install.sh $ENV
