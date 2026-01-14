@description('Key Vault name')
param keyVaultName string

@description('Location for Key Vault')
param location string 

@description('Enable soft delete')
param enableSoftDelete bool = false

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenant().tenantId
    enableRbacAuthorization: true
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: enableSoftDelete
    accessPolicies: []
  }
}

output vaultId string = keyVault.id
output vaultName string = keyVault.name
