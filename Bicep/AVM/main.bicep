targetScope = 'resourceGroup'

param keyVaultName string
param enablePurgeProtection bool = true

@secure()
param patToken string = newGuid()

param roleAssignments array = []


module myKeyVault 'br/public:avm/res/key-vault/vault:0.13.3' = {
  name: 'deploy-myKeyVault'
  params: {
    name: keyVaultName
    enablePurgeProtection: enablePurgeProtection
    secrets:[
      {
        name: 'PAT'
        value: patToken
      }
    ]
  roleAssignments: roleAssignments  
  }
}
