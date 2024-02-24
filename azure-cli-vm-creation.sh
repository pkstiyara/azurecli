az vm create \
    --resource-group 1-9b5c7497-playground-sandbox \
    --name vm1 \
    --location eastus \
    --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    --size Standard_D2s_v3 \
    --admin-username azure \
    --admin-password Password \
    --os-disk-size-gb 128 \

az vm create \
    --resource-group 1-9b5c7497-playground-sandbox \
    --name vm2 \
    --location eastus \
    --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    --size Standard_D2s_v3 \
    --admin-username azure \
    --admin-password Password \
    --os-disk-size-gb 128 \
