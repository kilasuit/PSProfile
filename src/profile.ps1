#region Create Variables
if (! $minprofile) {
. $PSScriptroot\variables.ps1
}
#endregion Create Variables
#region Create PSDrives
if (-not $PSDrives) {
. $PSScriptRoot\PSDrives.ps1
}
#endregion Create PSDrives

#region modules
## Todo move to script
Import-Module PriGH:\kilasuit\Modules-WIP\MyFunctions\MyFunctions.psd1 -DisableNameChecking

Import-Module PowerShellHumanizer
If ($iswindows) { Import-Module BetterCredentials -Prefix b }
# This was needed then seemingly not needed - I don't know why
# (Get-Module Posh-git -ListAvailable | Where-Object { $_.Version.Major -lt 1 }) | Import-Module
# If (Get-Module posh-git) { $GitPromptSettings.EnableWindowTitle = $null}
# Remove-Module posh-git
Import-Module C:\PSModules\posh-git\1.1.0\posh-git.psd1

Import-Module ClassExplorer

#$CheckGit = Request-YesOrNo -message 'Want to Check GitHub Status?'

#If ($CheckGit -eq $true) { Check-GithubRepoStatus }
#>
#endregion

#region completions
if ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -gt 4) {
    Get-ChildItem $PSScriptRoot\completions -Recurse -File | ForEach-Object { . $_.FullName }
}
#endregion completions

#region ISE Specific items
if ($host.Name -eq 'Windows PowerShell ISE Host') { . $PSScriptroot\ise_profile.ps1 }
#endregion

#region vscode Specific items
if ($host.Name -match 'Visual Studio Code Host') { . $PSScriptroot\code_profile.ps1 }
#endregion



#region preprompt

# function global:preprompt {
#     [CmdletBinding()]
#     [alias('pp')]
#     param (
#         [Parameter()]
#         [scriptblock]
#         $Scriptblock
#     )

#     $RunningAction = if ($Scriptblock.ToString().Length -gt 25) {$Scriptblock.ToString().Substring(0,25)} else {$Scriptblock.ToString().Substring(0,($Scriptblock.ToString().Length)) }

#     if ($PSVersionTable.PSEdition -match 'Desktop' -or $isWindows) {
#         $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
#         if ($admin -eq $true) {

#             # Admin-mark on prompt
#             Write-Host "[" -nonewline -foregroundcolor DarkGray
#             Write-Host "Admin" -nonewline -foregroundcolor Red
#             Write-Host "] " -nonewline -foregroundcolor DarkGray
#             $Host.UI.RawUI.WindowTitle = "[Admin] " + $WindowTitle + ' - ' + (Get-Date -Format HH:mm:ss) + ' - ' + $RunningAction
#         }
#         else {
#             $host.UI.RawUI.WindowTitle = $WindowTitle + ' - ' + (Get-Date -Format HH:mm:ss) + ' - ' + $RunningAction
#         }
#     }
#     Write-Host "[" -NoNewline
#     Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Gray -NoNewline
#     Write-Host "] [" -NoNewline
#     Write-Host $RunningAction -NoNewline
#     Write-Host "]" -NoNewline
#     Write-Host ''
#     $Scriptblock.Invoke()
# }
#endregion preprompt

. $PSScriptRoot\prompt.ps1


Remove-PSReadLineKeyHandler Ctrl+Enter

if ($isWindows -and ($host.Name -match 'ConsoleHost') -and ($wt)) {
    # Set-Location C:\ # Have commented this out as this breaks the Open In Terminal right click Explorer option
}
#


if ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -gt 2) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    if ((Get-Process -Id $Pid).Parent -notmatch 'Code') {
        Set-PSReadLineOption -PredictionViewStyle ListView
    }
}

Remove-Variable -Name minprofile -Scope Global -Force
