param location string
param clusterVnetCidr string
param masterSubnetCidr string
param workerSubnetCidr string


module vnet 'network/network.bicep' = {
  name: 'vnet'
  params: {
    clusterVnetCidr: clusterVnetCidr
    location: location
    masterSubnetCidr: masterSubnetCidr
    workerSubnetCidr: workerSubnetCidr
  }
}
