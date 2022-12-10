param appInsightsCS string
param appInsightsIK string
param location string = resourceGroup().location
param Environment string

var NamePostfix = '${Environment}${location}${uniqueString(resourceGroup().id)}'
var GenerateName = '${Environment}-${location}'
var GenerateUniqueName = substring(NamePostfix, 0, 20)

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: 'asp-${GenerateName}'
  location: location
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'asa-${GenerateUniqueName}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig:{
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsIK
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsCS
        }
        ] 
  }
}
}
