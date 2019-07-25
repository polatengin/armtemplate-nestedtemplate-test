$resourceGroup = Read-Host -Prompt "Please enter Resource Group Name"
$functionAppName = Read-Host -Prompt "Please enter the beginning of the Azure Functions names"
$count = Read-Host -Prompt "Please enter how many Azure Function you want"

az group create -l northeurope -n $resourceGroup

az group deployment create --resource-group $resourceGroup --template-file master.json --parameters functionName=$functionAppName functionCount=$count

cd appcode

dotnet publish -c Release -o publish

$publishZip = "publish.zip"

if (Test-path ../$publishZip) { Remove-item ../$publishZip }

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory("appcode/publish", $publishZip)

cd ..

For ($i=1; $i -le $count; $i++) {
    az functionapp deployment source config-zip -g $resourceGroup -n $functionAppName$i --src $publishZip
}

Remove-item $publishZip
