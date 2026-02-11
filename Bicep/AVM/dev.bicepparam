using 'main.bicep'

param vNetName = 'avm-vnet-01'
param location = 'uksouth'
param addressPrefixes = [
  '10.0.0.0/16'
]
param subnets = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
  }
  {
    name: 'subnet2'
    addressPrefix: '10.0.2.0/24'
  }
  {
    name: 'subnet3'
    addressPrefix: '10.0.3.0/24'
  }
]
