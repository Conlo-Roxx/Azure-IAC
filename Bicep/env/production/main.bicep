param location string = resourceGroup().location
param adminUsername string
@secure()
param adminPassword string 

module keyVault '../../modules/security/main.bicep' = {
  name: 'keyVault'
  params: {
    keyVaultName: 'ryan-kv'
    location: location
    adminPassword: adminPassword
  }
}
module network '../../modules/network/main.bicep' = {
  name: 'network'
  params: {
    vnetName: 'ryan-vnet'
    location: location
  }
}

module compute '../../modules/compute/main.bicep' = {
  name: 'compute'
  params: {
    vmName: 'ryan-vm'
    location: location
    subnetId: network.outputs.subnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}
module kvRbac '../../modules/security/rbac.bicep' = {
  name: 'kvRbac'
  params: {
    keyVaultName: keyVault.outputs.vaultName   
    principalId: compute.outputs.vmPrincipalId
    roleDefinitionGuid: '4633458b-17de-408a-b874-0445c86b69e6' // Key Vault Secrets User
  }
}
