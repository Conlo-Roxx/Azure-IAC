targetScope = 'resourceGroup'

// Virtual Network parameters
param vNetName string
param location string
param addressPrefixes array
param subnets array

// Deploy Virtual Network
module vNet1 'br/public:avm/res/network/virtual-network:0.7.2' = {
  name: 'deploy-vNet1'
  params: {
    name: vNetName
    location: location
    addressPrefixes: addressPrefixes
    subnets: subnets
    }
}
// Outputs
output vNetId string = vNet1.outputs.resourceId
output vNetName string = vNet1.outputs.name
output subnetIds array = vNet1.outputs.subnetResourceIds
