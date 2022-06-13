#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Argument manquant: <Environnement:[cdn1|cdn2|...]> <Region AWS:[us-east-1|eu-west-3|others]>"
  exit 1
fi


ENV=$1
aws kms create-alias --alias-name alias/$ENV-eksctl --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
