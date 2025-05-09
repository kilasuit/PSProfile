$WingetTypeDataParams = @{
    TypeName   = 'Microsoft.WinGet.Client.Engine.PSObjects.PSInstalledCatalogPackage'
    MemberType = 'AliasProperty'
    MemberName = 'IUA'
    Value      = 'IsUpdateAvailable'
    }
Update-TypeData @WingetTypeDataParams
