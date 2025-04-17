$PSDefaultParameterValues['Get-Command:CommandType'] = 'All'
$PSDefaultParameterValues['*-WinGetPackage:Source'] = 'winget'
# Flip this to Internal once you have an internal winget &  source
# $PSDefaultParameterValues['*-WinGetPackage:Source'] = 'internal'

# region to come back to
<#
if ($IsWindows) {
    if
}
if ($IsLinux) {}
#
$PSDefaultParameterValues['Import-Module:']
#>
#endregion to come back to
