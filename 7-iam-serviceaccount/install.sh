#https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html

#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Argument manquant: <Environnement:[cdn1|cdn2|...]>"
  exit 1
fi

ENV=$1
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export OIDC_PROVIDER=$(aws eks describe-cluster --name $ENV-eksctl --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")
export OIDC_ID=$(aws eks describe-cluster --name $ENV-eksctl --query "cluster.identity.oidc.issuer" --output text |awk -F "/" '{print $5}')

aws iam list-open-id-connect-providers | grep ${OIDC_ID}

eksctl utils associate-iam-oidc-provider --cluster $ENV-eksctl --approve

aws iam create-role --role-name $ENV-eksctl-bcloud-operator --assume-role-policy-document file://trust.json --description "role for bcloud"

aws iam attach-role-policy --role-name $ENV-eksctl-bcloud-operator --policy-arn=arn:aws:iam::aws:policy/AdministratorAccess
