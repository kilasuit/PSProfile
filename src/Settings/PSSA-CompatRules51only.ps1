@{
    IncludeDefaultRules = $true
    IncludeRules = @(
        'PSUseCompatibleSyntax',
        'PSUseCompatibleCmdlets'
    )
    Rules        = @{
        PSUseCompatibleCmdlets = @{
            'compatibility' = @('core-7.2.0-windows','core-7.2.0-macos')

        PSUseCompatibleSyntax = @{
            Enable         = $true
            TargetVersions = @(
                '5.1',
                '7.2',
                '7.4'
            )
        }
    }
}
}
