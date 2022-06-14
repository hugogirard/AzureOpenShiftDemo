param location string
param suffix string
param domain string
param masterSubnetId string
param workerSubnetId string

@secure()
param pullSecret string
@secure()
param aadClientId string
@secure()
param aadClientSecret string

var clusterName = 'aro-${suffix}'
var podCidr = '10.128.0.0/14'
var serviceCidr = '172.30.0.0/16'

resource clusterName_resource 'Microsoft.RedHatOpenShift/OpenShiftClusters@2020-04-30' = {
  name: clusterName
  location: location  
  properties: {
    clusterProfile: {
      domain: domain
      resourceGroupId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/aro-${domain}-${location}'
    }
    networkProfile: {
      podCidr: podCidr
      serviceCidr: serviceCidr
    }
    servicePrincipalProfile: {
      clientId: aadClientId
      clientSecret: aadClientSecret
    }
    masterProfile: {
      vmSize: 'Standard_D8s_v3'
      subnetId: masterSubnetId
    }
    workerProfiles: [
      {
        name: 'worker'
        vmSize: 'Standard_D4s_v3'
        diskSizeGB: 128
        subnetId: workerSubnetId
        count: 3
      }
    ]
    apiserverProfile: {
      visibility: 'Public'
    }
    ingressProfiles: [
      {
        name: 'default'
        visibility: 'Public'
      }
    ]
  }
}
