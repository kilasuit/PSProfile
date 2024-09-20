#region ISE Specific items
if ($host.Name -eq 'Windows PowerShell ISE Host') {
    Import-Module ISE_Cew
    Import-Module Modules-WIP:\ISEColorThemeCmdlets\ISEColorThemeCmdlets.psd1
    Set-ISETheme -File PublicGitHub:\kilasuit\PowerShell_ISE_Themes\Sublime_Text_2\Sublime_Text_2.StorableColorTheme.ps1xml

    $MyMenu = $psise.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('ISE_Cew', $null, $null)
    $MyMenu.Submenus.Add('Save & Commit Current ISE File', { Save-CurrentISEFile }, 'Ctrl+Alt+Shift+S') | Out-Null
    $MyMenu.Submenus.Add('Save & Commit all files that have been named', { Save-AllNamedFile }, 'Ctrl+Shift+S') | Out-Null
    $MyMenu.Submenus.Add('Save & Commit all unnamed files', { Save-AllUnnamedFile -GeneralModuleDetails $psd1 -DefaultPesterTests $DefaultPesterTests }, 'Ctrl+Alt+S') | Out-Null
    $MyMenu.Submenus.Add('Change to Nicer Colours', { Set-ISETheme -File PublicGitHub:\kilasuit\PowerShell_ISE_Themes\Sublime_Text_2\Sublime_Text_2.StorableColorTheme.ps1xml }, 'Ctrl+Alt+I') | Out-Null
    $MyMenu.Submenus.Add('Change to default Colours', { Set-ISETheme -File Modules-WIP:\ISEColorThemeCmdlets\Standard.StorableColorTheme.ps1xml }, 'Ctrl+Alt+K') | Out-Null
    $MyMenu.Submenus.Add('Align = signs in selected text.', { AlignEquals }, 'F6') | Out-Null
    $MyMenu.Submenus.Add('Clean up whitespace', { CleanWhitespace }, 'F7') | Out-Null
    $MyMenu.Submenus.Add('Start-Steroids', { Start-Steroids }, 'Alt+Shift+S') | Out-Null

    $psd1 = @{
        Path                 = '' #Please Leave blank as it is automatically populated by the function;
        Author               = 'Ryan Yates';
        CompanyName          = 'Re-Digitise Ltd';
        Copyright            = "(C) $(Get-Date -Format yyyy) Re-Digitise Ltd";
        RootModule           = '' # Please leave this blank as it is automatically populated by the function;
        Description          = 'Initial Description for *ModuleName*';
        ProjectUri           = [uri]"https://github.com/kilasuit/*ModuleName" # Suggested GitHub Location;
        LicenseUri           = [uri]"https://github.com/kilasuit/*ModuleName/readme.md' #Suggested *ModuleName";
        ReleaseNotes         = 'Initial starting release of this module';
        DefaultCommandPrefix = '';
        ModuleVersion        = '0.0.1'
        PrivateData          = @{Name = 'Ryan Yates'; Twitter = '@ryanyates1990'; BlogUrl = [URI]'https://blog.kilasuit.org/'; UkPowerShellUserGroup = [URI]'Https://powershell.org.uk' }
        FunctionsToExport    = '*'
    }
    $Default_Function_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\FunctionTests.txt"
    $Default_Module_Pester_Tests = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\ModuleTests.txt"
    $Standard_PSM1 = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\StandardPSM1.txt"
    $License_MD_Content = Get-Content -Path "$(Split-Path -Path ((Get-Module ISE_Cew).Path) -Parent)\Sample_LICENSE.MD"
    $License_MD_Content = $License_MD_Content.replace('Ryan Yates', $psd1.Author)
}
#endregion