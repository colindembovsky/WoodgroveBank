#!/bin/bash

# this runs after Codespace creation when a codespace is assigned to a user

echo "post-create start"
echo "$(date)    post-create start" >> "$HOME/status"

echo "create the services and deployments"
kubectl apply -f ./k8s/admin.yaml
kubectl apply -f ./k8s/api.yaml
kubectl apply -f ./k8s/dashboard.yaml

echo "set up port forwarding"
kubectl port-forward service/woodgrovebank-admin 5001:80
kubectl port-forward service/woodgrovebank-api 5000:80
kubectl port-forward service/woodgrovebank-dashboard 8080:80

echo "post-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    post-create complete" >> "$HOME/status"