param clusterVnetName string

@secure()
param aadObjectId string
@secure()
param rpObjectId string

var contribRole = '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'

resource clusterVnetName_Microsoft_Authorization_id_name_aadObjectId 'Microsoft.Network/virtualNetworks/providers/roleAssignments@2018-09-01-preview' = {
  name: '${clusterVnetName}/Microsoft.Authorization/${guid(resourceGroup().id, deployment().name, aadObjectId)}'
  properties: {
    roleDefinitionId: contribRole
    principalId: aadObjectId
  }
}

resource clusterVnetName_Microsoft_Authorization_id_name_rpObjectId 'Microsoft.Network/virtualNetworks/providers/roleAssignments@2018-09-01-preview' = {
  name: '${clusterVnetName}/Microsoft.Authorization/${guid(resourceGroup().id, deployment().name, rpObjectId)}'
  properties: {
    roleDefinitionId: contribRole
    principalId: rpObjectId
  }
}
