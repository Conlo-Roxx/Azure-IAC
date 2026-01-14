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

// Deterministic name for idempotency
var roleAssignmentName = guid(kv.id, principalId, roleDefinitionGuid)

// Create the role assignment scoped to the Key Vault resource symbol
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleAssignmentName
  scope: kv
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
  dependsOn: [
    kv
  ]
}

output roleAssignmentId string = roleAssignment.id
