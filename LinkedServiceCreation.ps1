Param($FILE, $FactoryName, $ServiceName, $ResourceGroup, $DataSource, $InitialCatalog, $Username, $Password)
    
#Params will be updated
 
az datafactory linked-service create --factory-name "datafactory-name" --properties '{"type": "SqlServer","typeProperties": {"connectionString": "Integrated Security=False;Data Source=<server name>;Initial Catalog=<database name>;User ID=<user id>;Password=<password>"}}' --name "script" --resource-group "resource-name"