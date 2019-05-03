APP_NAME=graphless16
DB_NAME=graphless16
COLLECTION_NAME=names
REPO_URL=https://github.com/simonaco/graphless

# create resource group
az group create --location uksouth --name $APP_NAME

# enable static storage
az extension add --name storage-preview

# deploy resource: az function, cosmosdb instance, storage account 
az group deployment create \
    --name $APP_NAME \
    --resource-group $APP_NAME \
    --template-file template/azuredeploy.json \
    --parameters appName=$APP_NAME repoURL=$REPO_URL

# generate dynamic url part for az functions enpoint
./env.sh > ./../graphiql/env.js "$APP_NAME"

# update static storage config for index and 404 files
az storage blob service-properties update --account-name "$APP_NAME" --static-website --404-document index.html --index-document index.html

# upload graphiql page & env file
az storage blob upload-batch -s graphiql -d \$web --account-name "$APP_NAME"

# fetch static website url 
STATIC_WEBSITE_URL=$(az storage account show -n "$APP_NAME" -g "$APP_NAME" --query "primaryEndpoints.web" --output tsv)

# remove trailing slash from static storage endpoint url
CORS_URL=$(echo $STATIC_WEBSITE_URL | sed 's/.$//')

# add static storage endpoint url to cors rules
az webapp cors add -g $APP_NAME -n $APP_NAME --allowed-origins $CORS_URL

az cosmosdb database create --resource-group $APP_NAME --name $APP_NAME --db-name $DB_NAME
az cosmosdb collection create --resource-group $APP_NAME --name $APP_NAME --collection-name $COLLECTION_NAME --db-name $DB_NAME
