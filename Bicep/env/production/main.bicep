param location string = resourceGroup().location
param adminUsername string
@secure()
param adminPassword string

module network '../../modules/network/main.bicep' = {
  name: 'network'
  params: {
    vnetName: 'learn-vnet'
    location: location
  }
}

module compute '../../modules/compute/main.bicep' = {
  name: 'compute'
  params: {
    vmName: 'learn-vm'
    location: location
    subnetId: network.outputs.subnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}
