param location string = resourceGroup().location
param Environment string

var GenerateName = '${Environment}-${location}'
var LogAnalyticsWorkspaceName = 'law-${GenerateName}'

resource  LogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: LogAnalyticsWorkspaceName
  location: location
}

resource ApplicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'AI-${GenerateName}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: LogAnalyticsWorkspace.id
  }
}
output appInsightsCS string = ApplicationInsights.properties.ConnectionString
output appInsightsIK string = ApplicationInsights.properties.InstrumentationKey
