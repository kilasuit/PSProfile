#$GitPromptSettings.EnableWindowTitle = $null
$script:PROFILEDirectory = $PSScriptRoot

#region ProfileBenchmark via script
. $PSScriptRoot\benchmark.ps1 -profilePath $MyInvocation.MyCommand.Source
#endregion ProfileBenchmark via script

. $PSScriptRoot\variables.ps1 -minprofile
. $PSScriptRoot\prompt.ps1 -minprofile
# . $PSScriptRoot\othermodules.ps1 -minprofile

# These are for testing
function invoke-minprofile {
    [CmdletBinding()]
    [Alias('imp')]
    param()
    . "$script:PROFILEDirectory\min-profile.ps1"
}

function invoke-profile {
    [CmdletBinding()]
    [Alias('imyp')]
    param()
    . "$script:PROFILEDirectory\profile.ps1"
}
