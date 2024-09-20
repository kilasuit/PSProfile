#region Create Variables
param(
    [switch]
    $minprofile
)

$script:PROFILEDirectory = $PSScriptRoot
$PROFILE | Add-Member -Name  MyProfileDirectory -MemberType NoteProperty -Value $script:PROFILEDirectory

<#$RYVars = []

class RYVars {

}
#>

if ($minprofile) {
    exit
} 

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
$SARules = @{
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


If ($PSVersionTable.PSVersion.Patch -gt 0) { $ver = $PSVersionTable.PSVersion.ToString() }
elseif ($PSVersionTable.PSVersion.PreReleaseLabel -match 'Daily') { $ver = '7 Daily' }
elseif ($PSVersionTable.PSVersion.PreReleaseLabel -match 'Preview') { $ver = "7 $($PSVersionTable.PSVersion.PreReleaseLabel)" }
else { $ver = $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor -join '.' }
if ((Get-Process -Id $PID).Path -match '\\WindowsApps\\Microsoft') { $ver = $ver + ' MSIX' }
if ((Get-Process -Id $PID).Path -match '\\PowerShell\\7') { $ver = $ver + ' MSI' }
if (((Get-Process -Id $pid).Parent.Parent.ProcessName -eq 'WindowsTerminal') -or (! $null -eq $env:wt_session) ) { $ver = $ver + ' WT' ; $wt = $true }


if ($isWindows) {
    $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    $WindowTitle = $ver + ' - ' + $pid
    $host.UI.RawUI.WindowTitle = $WindowTitle
    if ($admin -eq $true) {
        # Admin-mark in WindowTitle
        $Host.UI.RawUI.WindowTitle = "[Admin] " + $WindowTitle
    }
}

if ($PSVersionTable.PSEdition -match 'Desktop' -or $isWindows) {
    $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    if ($admin -eq $true) {

        # Admin-mark on prompt
        Write-Host "[" -NoNewline -ForegroundColor DarkGray
        Write-Host "Admin" -NoNewline -ForegroundColor Red
        Write-Host "] " -NoNewline -ForegroundColor DarkGray
        $Host.UI.RawUI.WindowTitle = "[Admin] " + $WindowTitle + ' - ' + (Get-Date -Format HH:mm:ss) + ' - ' + $RunningAction
    }
    else {
        $host.UI.RawUI.WindowTitle = $WindowTitle + ' - ' + (Get-Date -Format HH:mm:ss) + ' - ' + $RunningAction
    }
}

#endregion Create Variables