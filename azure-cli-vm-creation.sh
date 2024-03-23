# Fetch current resource group
resource_group=$(az group list --query '[0].name' -o tsv)

# Create VM using the fetched resource group
az vm create \
    --resource-group $resource_group \
    --name vm1 \
    --location eastus \
    --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    --size Standard_D2s_v3 \
    --admin-username azure \
    --admin-password Password@123 \
    --os-disk-size-gb 128




#Red Hat Enterprise Linux 8.7 (LVM) - Gen2

# Fetch current resource group
resource_group=$(az group list --query '[0].name' -o tsv)

# Create VM using the fetched resource group and RHEL image
az vm create \
    --resource-group $resource_group \
    --name rhel1 \
    --location eastus \
    --image RedHat:RHEL:87-gen2:latest \
    --size Standard_D2s_v3 \
    --admin-username azure \
    --admin-password Password@123 \
    --os-disk-size-gb 128


# Function to create multiple VM

#!/bin/bash

# Fetch current resource group
resource_group=$(az group list --query '[0].name' -o tsv)

# Function to create VM
create_vm() {
    az vm create \
        --resource-group $resource_group \
        --name $1 \
        --location eastus \
        --image RedHat:RHEL:87-gen2:latest \
        --size Standard_D2s_v3 \
        --admin-username azure \
        --admin-password Password@123 \
        --os-disk-size-gb 128
}

# Create VMs
create_vm rhel1
create_vm rhel2
create_vm rhel3



# Other method to create

for i in {1..3}; do \
    az vm create \
        --resource-group $(az group list --query '[0].name' -o tsv) \
        --name rhel$i \
        --location eastus \
        --image RedHat:RHEL:87-gen2:latest \
        --size Standard_D2s_v3 \
        --admin-username azure \
        --admin-password Password@123 \
        --os-disk-size-gb 128; \
done
This command c


