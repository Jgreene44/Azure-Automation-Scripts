#Example: KeyVaultCreation.ps1 -StageName Test -Names TestAPI, SendEmailAPI, UserAppKey
Param($StageName, [String[]] $SecretNames, $TestServiceCon , $TestServiceSecret , $AzureTenant, $ResourceGroup, $vaultName)

    $Environment
    if ($StageName -like 'Dev*') {
        Write-Output "Dev Stage"
        $Environment="Dev"
    }
    
    if ($StageName -like 'Test*') {
        Write-Output "Test Stage"
        $Environment="Test"
    }
    
    if ($StageName -like 'Prod*') {
        Write-Output "Prod Stage"
        $Environment="Prod"
    }


    #All Variables
    #Update Location
    $location=""
    $ResourceGroup= $ResourceGroup+$Environment
    $vaultName = $vaultName+$Environment

    az login --service-principal --username $TestServiceCon --password $TestServiceSecret --tenant $AzureTenant
    # Create the KeyVault, then get randomly generated values for the secrets.
    az keyvault create --name $vaultName --resource-group $ResourceGroup --location $location

    foreach($name in $SecretNames){
        Write-Host "Name is $name"
        # ASCII codes, (48-57): 0-9, (65-90): Upper Case A-Z, (97-122): Lower Case a-z  
        $Value = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_})
        az keyvault secret set --vault-name $vaultName --name $name --value $Value
    }
