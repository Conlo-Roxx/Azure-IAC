using 'main.bicep'

// environment specific values
param keyVaultName = 'avm-kv-dev-2907'
param enablePurgeProtection = false

param roleAssignments = [
  {
    principalId: 'e40625c3-8dc8-4118-9844-fd8019420d98' // example object id, replace with actual
    roleDefinitionIdOrName: 'Key Vault Secrets Officer' // example role definition id, replace with actual
  }
  {
    principalId: 'd2b1c3e4-5f6a-7b8c-9d0e-1f2a3b4c5d6e' // example object id, replace with actual
    roleDefinitionIdOrName: 'Key Vault Secrets User' // example role definition id, replace with actual
  }
]
