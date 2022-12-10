Connect-AzAccount

Set-Location -Path "C:\Users\Admin\OneDrive - Hortus Digital\learning\bicep\"

Set-AzContext -Subscription f1dd7b62-b530-4653-a66b-693b03895641

New-AzDeployment -TemplateFile main.bicep -Location westus3