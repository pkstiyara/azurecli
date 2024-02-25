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

# Step 4: Install Jenkins using Helm
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
helm install jenkins jenkinsci/jenkins --namespace jenkins --create-namespace

# Step 5: Expose Jenkins service with a LoadBalancer
kubectl expose service jenkins --type=LoadBalancer --name=jenkins-external -n jenkins

# Step 6: Wait for the external IP to be provisioned
EXTERNAL_IP=""
while [ -z $EXTERNAL_IP ]; do
    EXTERNAL_IP=$(kubectl get svc jenkins-external -n jenkins --no-headers -o custom-columns=":status.loadBalancer.ingress[0].ip")
    [ -z $EXTERNAL_IP ] && sleep 10
done

echo "Jenkins is accessible at: http://$EXTERNAL_IP:8080"
