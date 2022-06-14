targetScope='subscription'

param location string
param clusterVnetCidr string
param masterSubnetCidr string
param workerSubnetCidr string
param rgSpokeName string

@secure()
param domain string

@secure()
param aadClientId string
@secure()
param aadClientSecret string

var suffix = uniqueString(spokeRg.name)

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

module aro 'aro/aro.bicep' = {
  scope: resourceGroup(spokeRg.name)
  name: 'aro'
  params: {
    aadClientId: aadClientId
    aadClientSecret: aadClientSecret
    domain: domain
    location: location
    masterSubnetId: vnet.outputs.masterSubnetId    
    suffix: suffix
    workerSubnetId: vnet.outputs.workerSubnetId
  }
}
