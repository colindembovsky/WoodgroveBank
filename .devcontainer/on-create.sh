#!/bin/bash

# this runs at Codespace creation - not part of pre-build

echo "on-create start"
echo "$(date)    on-create start" >> "$HOME/status"

echo "create k3d cluster"
#alias k=kubectl
k3d registry create myregistry.localhost --port 12345
k3d cluster create --registry-use k3d-myregistry.localhost:12345

echo "create namespace"
kubectl create namespace woodgrovebank01
kubectl config set-context --current --namespace=woodgrovebank01 

echo "install nginx ingress"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml

echo "install keda"
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm install keda kedacore/keda --namespace woodgrovebank01

echo "install azurerite"
kubectl apply -f ./k8s/azurerite.yaml

echo "build the containers"
#docker-compose build

echo "push the containers to the local registry"
#docker-compose push

echo "on-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create complete" >> "$HOME/status"