$RG_NAME="data-pipeline-project"
$SA_NAME="dailyfunctionstorage"
$FUNCTION_APP_NAME="dailyjsonloaderfunc"
$LOCATION="southeastasia"
$FUNCTION_APP_CODE_PATH="C:\Users\magan\Desktop\ms-learn-data-pipeline\functions"

# My blob storage
$DATA_SA_NAME="mslearnjsonstorage"

# create a storage account for my function app
az storage account create `
--name $SA_NAME `
--location $LOCATION `
--resource-group $RG_NAME `
--sku Standard_LRS

# create the function app that will hold my function in vscode (TIMERTRIGGER)
Write-Host "Creating Function App..." -ForegroundColor Cyan
az functionapp create `
--name $FUNCTION_APP_NAME `
--storage-account $SA_NAME `
--consumption-plan-location $LOCATION `
--resource-group $RG_NAME `
--runtime python `
--runtime-version 3.11 `
--os-type Linux

# Get the connection string
$DATA_STORAGE_CONNECTION=$(az storage account show-connection-string `
  --name $DATA_SA_NAME `
  --resource-group $RG_NAME `
  --query connectionString `
  --output tsv)

az functionapp config appsettings set `
  --name $FUNCTION_APP_NAME `
  --resource-group $RG_NAME `
  --settings FUNCTIONS_WORKER_RUNTIME=python AzureWebJobsStorage="$DATA_STORAGE_CONNECTION" OutputStorageConnection="$DATA_STORAGE_CONNECTION"

  az functionapp config appsettings list `
  --name $FUNCTION_APP_NAME `
  --resource-group $RG_NAME `
  --output table


  # if you have other things add here also

# zip the function in my codebase
# Compress-Archive -Path $FUNCTION_APP_CODE_PATH\* -DestinationPath "$FUNCTION_APP_CODE_PATH\functionapp.zip"
# az functionapp deployment source config-zip `
# --name $FUNCTION_APP_NAME `
# --resource-group $RG_NAME `
# --src "$FUNCTION_APP_CODE_PATH\functionapp.zip"

# az functionapp deployment source config-zip `
# --name $FUNCTION_APP_NAME `
# --resource-group $RG_NAME `
# --src "$FUNCTION_APP_CODE_PATH\functionapp.zip"

# # verify
# az function app config appsettings list `
# --name $FUNCTION_APP_NAME `
# --resource-group $RG_NAME `
# --output table

func azure functionapp publish $FUNCTION_APP_NAME