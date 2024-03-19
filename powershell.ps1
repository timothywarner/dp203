# Variables
$resourceGroupName = "<YourResourceGroupName>"
$storageAccountName = "<YourStorageAccountName>"
$keyVaultName = "<YourKeyVaultName>"
$secretName = "<YourSecretName>"

# Login to Azure
Connect-AzAccount

# Get the storage account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

# Get the storage account keys
$keys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName

# Save the keys in the Key Vault
foreach ($key in $keys) {
    $secretValue = ConvertTo-SecureString -String $key.Value -AsPlainText -Force
    Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -SecretValue $secretValue
}

