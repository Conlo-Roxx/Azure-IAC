param location string = resourceGroup().location
param adminUsername string
@secure()
param adminPassword string

module keyVault '../../modules/security/main.bicep' = {
  name: 'keyVault'
  params: {
    keyVaultName: 'ryan-kv'
    location: location
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
module rbac '../../modules/security/rbac.bicep' = {
  name: 'rbac'
  params: {
    scopeId: keyVault.outputs.vaultId
    principalId: compute.outputs.vmPrincipalId
    roleDefinitionGuid: secretsUserRoleGuid
  }
}
