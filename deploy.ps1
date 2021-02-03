# Connect-AzAccount

Set-AzContext -Subscription "Pay-As-You-Go(Converted to EA)"

New-AzResourceGroup `
  -Name templateSpecRG `
  -Location westus2

# Create a template spec in the res
New-AzTemplateSpec `
  -Name webSpec `
  -Version "1.0.0.0" `
  -ResourceGroupName templateSpecRG `
  -Location westus2 `
  -TemplateFile "e:\ARM\linkedTS\azuredeploy.json"

# We can see that the template spec now exists using...  
Get-AzTemplateSpec -ResourceGroupName templatespecRG -Name webSpec


# We can now deploy by using the template spec we just created...
New-AzResourceGroup `
  -Name webRG `
  -Location westus2

$id = (Get-AzTemplateSpec -ResourceGroupName templateSpecRG -Name webSpec -Version "1.0.0.0").Versions.Id

New-AzResourceGroupDeployment `
  -TemplateSpecId $id `
  -ResourceGroupName webRG
