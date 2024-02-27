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
