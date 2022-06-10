targetScope='subscription'

param location string
param clusterVnetCidr string
param masterSubnetCidr string
param workerSubnetCidr string
param rgSpokeName string


resource spokeRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgSpokeName
  location: location
}

module vnet 'network/network.bicep' = {
  scope: resourceGroup(spokeRg.name)
  name: 'vnet'
  params: {
    clusterVnetCidr: clusterVnetCidr
    location: location
    masterSubnetCidr: masterSubnetCidr
    workerSubnetCidr: workerSubnetCidr
  }
}
