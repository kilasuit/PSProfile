#$GitPromptSettings.EnableWindowTitle = $null
$script:PROFILEDirectory = $PSScriptRoot
#$PROFILE | Add-Member -Name  MyProfileDirectory -MemberType NoteProperty -Value $script:PROFILEDirectory
$minprofile = $true
. $PSScriptRoot\variables.ps1 -minprofile 

. $PSScriptRoot\prompt.ps1 -minprofile

function invoke-minprofile {
    [CmdletBinding()]
    [Alias('imp')]
    param()
    . "$script:PROFILEDirectory\min-profile.ps1"
}