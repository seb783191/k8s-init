#!/bin/bash
#curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.1.3/docs/install/iam_policy.json

#aws iam create-policy \
#   --policy-name ALBIngressControllerIAMPolicy \
#   --policy-document file://iam_policy.json
if [ $# -lt 1 ]; then
  echo "Argument manquant: <Environnement:[cdn1|cdn2|...]>"
  exit 1
fi
ENV=$1

CLUSTER_NAME=$ENV-eksctl
AWS_ACCOUNT_ID=${ACCOUNT_ID}
VPC_ID=${VPC_ID}
#eksctl utils associate-iam-oidc-provider --cluster $CLUSTER_NAME --approve
#eksctl create iamserviceaccount \
#  --cluster=$CLUSTER_NAME \
#  --namespace=kube-system \
#  --name=aws-load-balancer-controller \
#  --attach-policy-arn=arn:aws:iam::${AWS_ACCOUNT_ID}:policy/ALBIngressControllerIAMPolicy \
#  --override-existing-serviceaccounts \
#  --approve

#eksctl get iamserviceaccount --cluster $CLUSTER_NAME --name aws-load-balancer-controller --namespace kube-system

#kubectl get serviceaccount aws-load-balancer-controller --namespace kube-system
helm repo add eks https://aws.github.io/eks-charts

kubectl create namespace ingress-controller

#kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n ingress-controller --set clusterName=$CLUSTER_NAME
