# In this file, we define a number of variables to be used across sessions
# This allows us
#region Create Variables
param(
    [switch]
    $minprofile
)

$script:sessionStart = (Get-Date -Format yyyy-MMM-dd-HH:mm:ss)

$script:PROFILEDirectory = $PSScriptRoot
$script:PROFILEGitDirectory = "$PSScriptRoot\..\"

if (! $profile.MyProfileDirectory) {
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

## Setting this to allow quick refresh of Bluetooth adapter due to an intermittent issue with mouse disconnecting erratically - this is a workaround and sometimes fails to work - perhaps due to it being an older aging device whether driver/firmware related or due to overheating
if ($env:COMPUTERNAME -eq 'INTEL-NUC' -and $admin) {
    $bluetoothAdapter = Get-PnpDevice -Class Bluetooth -FriendlyName *Intel*
    function Reset-BluetoothAdapter {
        [CmdletBinding()]
        [Alias('rsba')]
        param()
        $bluetoothAdapter | Disable-PnpDevice -Confirm:$false -PassThru | Enable-PnpDevice -Confirm:$false
    }
}

# region hostui
. $PSScriptRoot\hostui.ps1 -minprofile:$minprofile
# endregion hostui
if ($minprofile) {
    exit
}

#region default params
. "$PSScriptRoot\vars\DefaultParams.ps1"
#endregion
# Please note the below with the PrivateData Section which is suggested for you to use for surfacing additional information about the module and the author/s
$psd1 = @{
    Path                 = '' #Please Leave blank as it is automatically populated by the function; # TODO fit it in vscode setup
    Author               = 'Ryan Yates'
    CompanyName          = 'Re-Initialise'
    Copyright            = "(C) $(Get-Date -Format yyyy) Re-Initialise"
    RootModule           = '' # Please leave this blank as it is automatically populated by the function;
    Description          = 'Initial Description for *ModuleName*'
    ProjectUri           = [uri]"https://github.com/kilasuit/modules" # Suggested GitHub Location;
    LicenseUri           = [uri]"https://github.com/kilasuit/modules/License' #Suggested *ModuleName"
    ReleaseNotes         = 'Initial starting release of this module'
    DefaultCommandPrefix = ''
    ModuleVersion        = '0.0.1'
    PrivateData          = @{
        Name                  = 'Ryan Yates'
        'Twitter/X'           = '@ryanyates1990'
        BlogUrl               = [URI]'https://blog.kilasuit.org/'
        LinkedIn              = [URI]'https://www.linkedin.com/in/ryanyates1990/'
        UkPowerShellUserGroup = [URI]'https://powershell.org.uk'
        BlueSky               = [URI]'https://bsky.app/profile/blog.kilasuit.org/'
        GitHub                = [URI]'https://github.com/kilasuit'
        Slack                 = 'pwshdoodUK'
        SlackCommunity        = [URI]'https://aka.ms/PSSlack'
        Discord               = 'pwshdoodUK'
        DiscordCommunity      = [URI]'https://aka.ms/PSDiscord'
        Twitch                = 'pwshdoodUK'
    }
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

# This section would allow for Pester related settings and defaults - this is very old code
# based on IRRC v3 back in 2016 and needs updating to v4/v5/v6 features in future
## TODO: Update this to Pester v4/v5/v6
#region Pester variables

# $Default_Function_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\FunctionTests.txt"
# $Default_Module_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\ModuleTests.txt"
# $Standard_PSM1 = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\StandardPSM1.txt"
# $License_MD_Content = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\Sample_LICENSE.MD"
# $License_MD_Content = $License_MD_Content.replace('Ryan Yates', $psd1.Author)



#endregion Create Variables
# I do this to ensure that the minprofile varaible is not available if I then choose to
# invoke the full profile
Get-Variable minprofile -ErrorAction SilentlyContinue | Remove-Variable -Scope Global -Force -ErrorAction SilentlyContinue
