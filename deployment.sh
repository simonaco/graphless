RESOURCE_GROUP=graphless11
STORAGE_ACC=cspace11
STATIC_WEBSITE_URL="https://$STORAGE_ACC.z6.web.core.windows.net"

az group create --location uksouth --name $RESOURCE_GROUP
az group deployment create \
    --name $RESOURCE_GROUP \
    --resource-group $RESOURCE_GROUP \
    --template-file azuredeploy.json \
    --parameters azuredeploy.parameters.json


az webapp cors add -g $RESOURCE_GROUP -n $STORAGE_ACC --allowed-origins $STATIC_WEBSITE_URL

az extension add --name storage-preview

env.sh > env.js

az storage blob service-properties update --account-name $STORAGE_ACC --static-website --404-document index.html --index-document index.html

az storage blob upload-batch -s graphiql -d \$web --account-name $STORAGE_ACC