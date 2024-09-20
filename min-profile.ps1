#$GitPromptSettings.EnableWindowTitle = $null
$script:PROFILEDirectory = $PSScriptRoot
$PROFILE | Add-Member -Name  MyProfileDirectory -MemberType NoteProperty -Value $script:PROFILEDirectory
$minprofile = $true
. $PSScriptRoot\variables.ps1 -minprofile 

. $PSScriptRoot\prompt.ps1 -minprofile
