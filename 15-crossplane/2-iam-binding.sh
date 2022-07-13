#https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html

#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Argument manquant: <Environnement:[cdn1|cdn2|...], ServiceAccountName>"
  exit 1
fi

ENV=$1
NAMESPACE=crossplane-system
SERVICE_ACCOUNT_NAME=$2
file=trust-$ENV.json

export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export OIDC_PROVIDER=$(aws eks describe-cluster --name $ENV-eksctl --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")
export OIDC_ID=$(aws eks describe-cluster --name $ENV-eksctl --query "cluster.identity.oidc.issuer" --output text |awk -F "/" '{print $5}')

#aws iam list-open-id-connect-providers | grep ${OIDC_ID}

#sed
sed -e 's|ACCOUNT_ID|'$ACCOUNT_ID'|; s|OIDC_PROVIDER|'$OIDC_PROVIDER'|; s|OIDC_ID|'$OIDC_ID'|; s|NAMESPACE|'$NAMESPACE'|; s|SERVICE_ACCOUNT_NAME|'$SERVICE_ACCOUNT_NAME'|' trust.json > $file

eksctl utils associate-iam-oidc-provider --cluster $ENV-eksctl --approve
aws iam create-role --role-name $ENV-eksctl-$NAMESPACE --assume-role-policy-document file://$file --description "role for bcloud"
aws iam attach-role-policy --role-name $ENV-eksctl-$NAMESPACE --policy-arn=arn:aws:iam::aws:policy/AdministratorAccess
rm $file
