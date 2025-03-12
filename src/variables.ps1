#region Create Variables
param(
    [switch]
    $minprofile
)
if ($minprofile) {
    $script:sessionStart = (Get-Date -Format yyyy-MMM-dd-HH:mm:ss)

    $script:PROFILEDirectory = $PSScriptRoot
    $script:PROFILEGitDirectory = "$PSScriptRoot\..\"

    $PROFILE | Add-Member -Name  MyProfileDirectory -MemberType NoteProperty -Value $script:PROFILEDirectory
    $PROFILE | Add-Member -Name  MyProfileGitDirectory -MemberType NoteProperty -Value $script:PROFILEGitDirectory
}
function Set-WindowTitle {
    [CmdletBinding()]
    [Alias('shwt')]
    param (
        [Parameter()]
        [string]
        $WindowTitle
    )
    $host.UI.RawUI.WindowTitle = $WindowTitle
}

#Set-WindowTitle -WindowTitle $windowTitle
if ($PSVersionTable.PSVersion.Major -lt 6) {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidAssignmentToAutomaticVariable', 'Not Available in v6 or lower unless PowerShellGet is imported', Scope = 'Scriptblock')]
    $isWindows = $true
}

if ($isWindows) {
    $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
} else {
    # Check if running as root on Linux
    # Thanks to jborean93 for the Linux check
    # https://discord.com/channels/180528040881815552/447476117629304853/1316552171348688926
    $uid = id -u
    if ($uid -eq 0) {
        $admin = $true
    }
}

## Setting this to allow quick refresh of Bluetooth adapter due to an intermittent issue with mouse disconnecting
if ($env:COMPUTERNAME -eq 'INTEL-NUC' -and $admin) {
    $bluetoothAdapter =  Get-PnpDevice -Class Bluetooth -FriendlyName *Intel*
    function Reset-BluetoothAdapter {
        [CmdletBinding()]
        [Alias('rsba')]
        param()
        $bluetoothAdapter | disable-PnpDevice -Confirm:$false -PassThru | Enable-PnpDevice -Confirm:$false
    }
}

. $PSScriptRoot\hostui.ps1 -minprofile:$minprofile

if ($minprofile) {
    exit
}

#region def
. "$PSScriptRoot\vars\DefaultParams.ps1"
#endregion
$psd1 = @{
    Path                 = '' #Please Leave blank as it is automatically populated by the function; # TODO fit it in vscode setup
    Author               = 'Ryan Yates';
    CompanyName          = 'Re-Initialise';
    Copyright            = "(C) $(Get-Date -Format yyyy) Re-Initialise";
    RootModule           = '' # Please leave this blank as it is automatically populated by the function;
    Description          = 'Initial Description for *ModuleName*';
    ProjectUri           = [uri]"https://github.com/kilasuit/modules" # Suggested GitHub Location;
    LicenseUri           = [uri]"https://github.com/kilasuit/modules/License' #Suggested *ModuleName";
    ReleaseNotes         = 'Initial starting release of this module';
    DefaultCommandPrefix = '';
    ModuleVersion        = '0.0.1'
    PrivateData          = @{Name = 'Ryan Yates'; Twitter = '@ryanyates1990'; BlogUrl = [URI]'https://blog.kilasuit.org/'; UkPowerShellUserGroup = [URI]'https://powershell.org.uk' }
    FunctionsToExport    = '*'
}

#region ScriptAnalyser Specific Items
$ScriptAnalyserRules = @{
    Severity     = 'Warning'
    IncludeRules = @('PSAvoidUsingCmdletAliases',
        'PSAvoidUsingPositionalParameters',
        'PSAvoidUsingInternalURLs'
        'PSAvoidUninitializedVariable')
    ExcludeRules = @('PSAvoidUsingCmdletAliases'
        'PSAvoidUninitializedVariable')
}
#endregion

# $Default_Function_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\FunctionTests.txt"
# $Default_Module_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\ModuleTests.txt"
# $Standard_PSM1 = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\StandardPSM1.txt"
# $License_MD_Content = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\Sample_LICENSE.MD"
# $License_MD_Content = $License_MD_Content.replace('Ryan Yates', $psd1.Author)

# if ($PSVersionTable.PSEdition -match 'Desktop' -or $isWindows) {
#     $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
#     if ($admin -eq $true) {

#         # Admin-mark on prompt
#         Write-Host "[" -NoNewline -ForegroundColor DarkGray
#         Write-Host "Admin" -NoNewline -ForegroundColor Red
#         Write-Host "] " -NoNewline -ForegroundColor DarkGray
#         $Host.UI.RawUI.WindowTitle = "[Admin] " + $WindowTitle + ' - ' + $ # + ' - ' + $RunningAction
#     }
#     else {
#         $host.UI.RawUI.WindowTitle = $WindowTitle + ' - ' + (Get-Date -Format HH:mm:ss) + ' - ' + $RunningAction
#     }
# }

#endregion Create Variables
Remove-Variable -Name minprofile -Scope Global -Force
