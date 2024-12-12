<#
Call this in a new powershell/pwsh session with -noprofile 
requires 
git
posh-git v0.7.3 / v1.1.0 to test 
powershellHumanizer module 
load this and then navigate to a 
#>
If(Get-Module Posh-git) {Remove-Module Posh-git -force}
$version = read-host "Enter 1 to load posh-git v0.7.3 : Enter 2 for 1.1.0"
switch ($version) {
    1 { import-module Posh-Git -version '0.7.3' -force}
    2 { import-module C:\tmp\posh-git\posh-git\1.1.0\posh-git.psd1 -force}
    Default {}
}
Import-Module PowerShellHumanizer

function global:prompt {
    Write-Host "[" -NoNewline
    Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Gray -NoNewline
    Write-Host "] [" -NoNewline
    ## This is for v5 compatibility as in v7 there is a duration property that we could use
    If ((Microsoft.PowerShell.Core\Get-History)) {
        Write-Host "$((((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime)).Humanize(4))" -NoNewline -ForegroundColor Gray
    }
    Write-Host "]" -NoNewline
    #Write-Host " - [$(((get-date -Date 20/06/2022 )- (Get-Date)).Days) till PSConfEU]" -NoNewline
    if (Get-Module Posh-git) { Write-VcsStatus }
    Write-Host ' '
    "$($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "#
}
# Change this to a location where you have a git repo where your local copy has diverged from the cloud repo
Cd C:\tmp\powerShell