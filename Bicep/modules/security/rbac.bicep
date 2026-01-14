@description('Existing Key Vault name')
param keyVaultName string

@description('Principal object id to grant the role to')
param principalId string

@description('Role definition GUID')
param roleDefinitionGuid string

// Existing resource for Key Vault
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

// Build the full role definition id at subscription scope
var roleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionGuid)

// Create a GUID value from the inputs (kv id, principal id, and role definition)
// This ensure on redeployment no new assignments are created as the name remains the same *VERY IMPORTANT*
var roleAssignmentName = guid(kv.id, principalId, roleDefinitionGuid)

// Create the role assignment scoped to the Key Vault resource symbol
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleAssignmentName
  scope: kv
  properties: {
    roleDefinitionId: roleDefinitionId       //This is created above using the role definition GUID from the main bicep file
    principalId: principalId                 // this is set in the main bicep file from the VM's managed identity
    principalType: 'ServicePrincipal' 
  }
  dependsOn: [
    kv
  ]
}

output roleAssignmentId string = roleAssignment.id
