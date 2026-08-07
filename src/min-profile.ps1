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
    $minprofile = $true
}

function invoke-profile {
    [CmdletBinding()]
    [Alias('imyp')]
    param()
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    . $Profile.CurrentUserAllHosts
    Remove-Variable minprofile -Force
    $sw.Stop()
    Write-Output "Profile Load Time: $($sw.Elapsed.TotalSeconds) seconds"
}
