az group create --location uksouth --name graphless11
az group deployment create \
    --name graphless11 \
    --resource-group graphless11 \
    --template-file azuredeploy.json \
    --parameters azuredeploy.parameters.json
