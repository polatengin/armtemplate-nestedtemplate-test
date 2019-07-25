$resourceGroup = "testing"
$functionAppName = "functest20190725"
$count = 4

az group deployment create --resource-group $resourceGroup --template-file master.json --parameters functionName=$functionAppName count=$count

cd appcode

dotnet publish -c Release
$publishFolder = "./appcode/bin/Release/netcoreapp2.1/publish"

$publishZip = "publish.zip"
if (Test-path $publishZip) { Remove-item $publishZip }

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($publishFolder, $publishZip)

az functionapp deployment source config-zip -g $resourceGroup -n $functionAppName --src $publishZip
