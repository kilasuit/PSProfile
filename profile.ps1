#region Create Variables
. $PSScriptroot\variables.ps1
#endregion Create Variables

#region Create PSDrives
if ($PSVersionTable.PSVersion.Major -lt 6) { 
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidAssignmentToAutomaticVariable', 'Not Available in v6 or lower unless PowerShellGet is imported', Scope = 'Scriptblock')]
    $isWindows = $true 
}
if ($isWindows) {
    #New-PSDrive -Name Desktop -PSProvider FileSystem -Root $env:HOMEDRIVE$env:HOMEPATH\Desktop | Out-Null
    New-PSDrive -Name OneDrive -PSProvider FileSystem -Root $env:HOMEDRIVE$env:HOMEPATH\Onedrive\ | Out-Null
    New-PSDrive -Name Code -PSProvider FileSystem -Root C:\code\ | Out-Null
    New-PSDrive C-Tmp -PSProvider FileSystem -Root C:\Tmp\ | Out-Null
    New-PSDrive C-Temp -PSProvider FileSystem -Root c:\Temp\ | Out-Null
}
if ($IsLinux) {
    New-PSDrive Code -PSProvider FileSystem -Root '/mnt/c/Code/' | Out-Null
    New-PSDrive C-Tmp -PSProvider FileSystem -Root '/mnt/c/Tmp/' | Out-Null
    New-PSDrive C-Temp -PSProvider FileSystem -Root '/mnt/c/Temp/' | Out-Null
    $Env:PSModulePath = $Env:PSModulePath + ':/mnt/c/Program Files/WindowsPowerShell/Modules/'
}

New-PSDrive -Name Private -PSProvider FileSystem -Root 'Code:\Mine\pri\' | Out-Null
New-PSDrive -Name Public -PSProvider FileSystem -Root 'Code:\Mine\pub\' | Out-Null

New-PSDrive -Name PrivateGitHub -PSProvider FileSystem -Root 'Code:\Mine\pri\Github\' | Out-Null
New-PSDrive -Name PublicGitHub -PSProvider FileSystem -Root 'Code:\Mine\pub\Github\' | Out-Null

New-PSDrive -Name Scripts -PSProvider FileSystem -Root 'PrivateGitHub:\kilasuit\Scripts' | Out-Null
New-PSDrive -Name Scripts-WIP -PSProvider FileSystem -Root 'PrivateGitHub:\kilasuit\Scripts-WIP' | Out-Null
New-PSDrive -Name Modules-WIP -PSProvider FileSystem -Root 'PrivateGitHub:\kilasuit\Modules-WIP' | Out-Null
New-PSDrive -Name Blog -PSProvider FileSystem -Root 'PrivateGitHub:\kilasuit\blogsite' | Out-Null
New-PSDrive -Name Mhasl -PSProvider FileSystem -Root 'PrivateGitHub:\mhaslme\website' | Out-Null
New-PSDrive -Name Profile -PSProvider FileSystem -Root 'PrivateGitHub:\kilasuit\PSProfile' | Out-Null

#endregion

#region modules
Import-Module PrivateGitHub:\kilasuit\Modules-WIP\MyFunctions\MyFunctions.psd1 -DisableNameChecking

Import-Module PowerShellHumanizer
If ($iswindows) { Import-Module BetterCredentials -Prefix b }
(Get-Module Posh-git -ListAvailable | Where-Object { $_.Version.Major -lt 1 }) | Import-Module
$GitPromptSettings.EnableWindowTitle = $null

#$CheckGit = Request-YesOrNo -message 'Want to Check GitHub Status?'

#If ($CheckGit -eq $true) { Check-GithubRepoStatus }
#>
#endregion

#region ISE Specific items
if ($host.Name -eq 'Windows PowerShell ISE Host') { . $PSScriptroot\ise_profile.ps1 }
#endregion

#region vscode Specific items
if ($host.Name -match 'Visual Studio Code Host') { . $PSScriptroot\code_profile.ps1 }
#endregion


#>

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

if ($isWindows -and ($host.Name -match 'ConsoleHost') -and ($wt)) { Set-Location C:\ }



if ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -gt 2) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    if ((Get-Process -Id $Pid).Parent -notmatch 'Code') {
        Set-PSReadLineOption -PredictionViewStyle ListView
    }
}

