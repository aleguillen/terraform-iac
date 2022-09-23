# Reference: https://www.terraform.io/language/settings/backends/azurerm

RESOURCE_GROUP_NAME=$(terraform output -raw tf_resource_group_name)
STORAGE_ACCOUNT_NAME=$(terraform output -raw tf_storage_account_name)

echo "resource_group_name=$RESOURCE_GROUP_NAME"
echo "storage_account_name=$STORAGE_ACCOUNT_NAME"

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY