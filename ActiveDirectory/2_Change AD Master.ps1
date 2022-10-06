Import-Module activedirectory
Get-ADForest DOMAIN.LOCAL| ft DomainNamingMaster, SchemaMaster
Get-ADDomain DOMAIN.LOCAL | ft InfrastructureMaster, PDCEmulator, RIDMaster
Get-ADObject (Get-ADRootDSE).schemaNamingContext -Property objectVersion
Move-ADDirectoryServerOperationMasterRole -Identity “SRVDC” –OperationMasterRole DomainNamingMaster,PDCEmulator,RIDMaster,SchemaMaster,InfrastructureMaster