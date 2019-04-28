az group create --location uksouth --name graphless11
az group deployment create \
    --name graphless11 \
    --resource-group graphless11 \
    --template-file azuredeploy.json \
    --parameters azuredeploy.parameters.json

az webapp cors add -g graphless11 -n cspace11 --allowed-origins https://cspaceclient11.z6.web.core.windows.net

az extension add --name storage-preview

az storage blob service-properties update --account-name cspaceclient11 --static-website --404-document index.html --index-document index.html

az storage blob upload-batch -s graphiql/index.html -d \$web --account-name cspaceclient11
