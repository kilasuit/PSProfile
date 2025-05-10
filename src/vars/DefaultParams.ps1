# region winget

$PSDefaultParameterValues['Get-Command:CommandType'] = 'All'
$PSDefaultParameterValues['*-WinGetPackage:Source'] = 'winget'
# Flip this to Internal once you have an internal winget source setup
# $PSDefaultParameterValues['*-WinGetPackage:Source'] = 'internal'

#endregion winget


## Remoting DefaultVars
$PSDefaultParameterValues['*-PSSession:ConfigurationName'] ='PowerShell.7-preview'
$PSDefaultParameterValues['Invoke-Command:ConfigurationName'] ='PowerShell.7-preview'

