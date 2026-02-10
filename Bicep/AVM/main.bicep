targetScope = 'resourceGroup'

// Key Vault parameters
param keyVaultName string
param enablePurgeProtection bool = true
@secure()
param patToken string = newGuid()
param roleAssignments array = []

// Virtual Network parameters
param vNetName string
param location string
param addressPrefixes array

// Deploy Key Vault
module myKeyVault 'br/public:avm/res/key-vault/vault:0.13.3' = {
  name: 'deploy-myKeyVault'
  params: {
    name: keyVaultName
    enablePurgeProtection: enablePurgeProtection
    roleAssignments: roleAssignments
    secrets: [
      {
        name: 'PAT'
        value: patToken
      }
    ]
  }
}

// Deploy Virtual Network
module vNet1 'br/public:avm/res/network/virtual-network:0.7.2' = {
  name: 'deploy-vNet1'
  params: {
    name: vNetName
    location: location
    addressPrefixes: addressPrefixes
  }
}
