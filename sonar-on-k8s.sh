#!/bin/bash

# Step 1: Get the resource group
RG=$(az group list --query '[0].name' -o tsv)

# Step 2: Create the AKS cluster
az aks create \
 --resource-group $RG \
 --name Cluster01 \
 --node-count 3 \
 --generate-ssh-keys \
 --node-vm-size Standard_D2s_v3 \
 --enable-managed-identity

# Step 3: Get the Kubernetes credentials
az aks get-credentials --name Cluster01 --resource-group $RG

# Step 4: Install SonarQube using Helm
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install sonarqube stable/sonarqube --namespace sonarqube --create-namespace

# Step 5: Expose SonarQube service with a LoadBalancer
kubectl expose service sonarqube-sonarqube --type=LoadBalancer --name=sonarqube-external -n sonarqube

# Step 6: Wait for the external IP to be provisioned
EXTERNAL_IP=""
while [ -z $EXTERNAL_IP ]; do
    EXTERNAL_IP=$(kubectl get svc sonarqube-external -n sonarqube --no-headers -o custom-columns=":status.loadBalancer.ingress[0].ip")
    [ -z $EXTERNAL_IP ] && sleep 10
done

echo "SonarQube is accessible at: http://$EXTERNAL_IP:9000"

