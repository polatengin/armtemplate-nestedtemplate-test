$resourceGroup = "test2019"
$functionAppName = "functest20190725"
$count = 10

az group create -l northeurope -n $resourceGroup

az group deployment create --resource-group $resourceGroup --template-file master.json --parameters functionName=$functionAppName count=$count

cd appcode

dotnet publish -c Release -o publish

$publishZip = "publish.zip"

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory("appcode/publish", $publishZip)

cd ..

For ($i=1; $i -le $count; $i++) {
    az functionapp deployment source config-zip -g $resourceGroup -n $functionAppName$i --src $publishZip
}

Remove-item $publishZip
