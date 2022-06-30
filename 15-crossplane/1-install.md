#!/bin/bash

#Creer le namespace
kubectl create namespace crossplane-system

#Install Crossplane
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

helm install crossplane --namespace crossplane-system crossplane-stable/crossplane

#Configure the Provider

k apply -f controllerconfig-provider.yaml

## Installer la configuration
kubectl crossplane install configuration registry.upbound.io/xp/getting-started-with-aws:v1.5.1

## Installer le provider
k apply -f providerconfig-with-role.yaml


Récuperer le serviceAccount du provider-aws
Changer la valeur SERVICE_ACCOUNT_NAME dans 2-iam-binding.sh
Appliquer 2-iam-binding.sh
