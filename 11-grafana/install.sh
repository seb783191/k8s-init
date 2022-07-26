#!/bin/bash
# add grafana Helm repo
helm repo add grafana https://grafana.github.io/helm-charts

kubectl create namespace grafana

helm dependency build

helm upgrade --install grafana -f values.yaml . -n grafana

