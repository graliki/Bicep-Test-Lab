param location string = 'westus3'
param Environment string = 'test'

targetScope = 'subscription'

var rgname = 'rg-${Environment}-aleksandrs'
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgname
  location: location
}

module Workspace 'modules/Workspace.bicep' = {
  name: 'Workspace'
  scope: rg
  params: {
    location: location
    Environment: Environment
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  scope: rg
  params: {
    location: location
    Environment: Environment
    appInsightsCS: Workspace.outputs.appInsightsCS
    appInsightsIK: Workspace.outputs.appInsightsIK
  }
  dependsOn:[
    Workspace
  ]
}
