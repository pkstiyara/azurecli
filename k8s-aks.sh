#!/bin/bash

# Step 1: Get the resource group
RG=$(az group list --query '[0].name' -o tsv)

# Step 2: Create the AKS cluster
az aks create \
 --resource-group $RG \
 --name myakscluster \
 --node-count 3 \
 --generate-ssh-keys \
 --node-vm-size Standard_D2s_v3 \
 --enable-managed-identity

# Step 3: Get the Kubernetes credentials
az aks get-credentials --name Cluster01 --resource-group $RG
