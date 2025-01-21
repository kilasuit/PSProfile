If ($PSVersionTable.PSVersion.Patch -gt 0) { $ver = $PSVersionTable.PSVersion.ToString() }
elseif ($PSVersionTable.PSVersion.PreReleaseLabel -match 'Daily') { $ver = '7 Daily' }
elseif ($PSVersionTable.PSVersion.PreReleaseLabel -match 'Preview') { $ver = $($PSVersionTable.PSVersion.ToString().replace('0-preview', 'p')) }
elseif ($PSVersionTable.PSVersion.PreReleaseLabel -match 'rc') { $ver = "$($PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor -join '.') RC" }
else { $ver = $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor -join '.' }


if ((Get-Process -Id $PID).Path -match '\\WindowsApps\\Microsoft') { $ver = $ver + ' MSIX' }
elseif ((Get-Process -Id $PID).Path -match '\\PowerShell\\7') { $ver = $ver + ' MSI' }
elseif ($PSEdition -eq 'Desktop') { $ver = $ver }
else {$ver = $ver + 'ZIP'}

if (((Get-Process -Id $pid).Parent.Parent.ProcessName -eq 'WindowsTerminal') -or (! $null -eq $env:wt_session) ) { $ver = $ver + ' WT' ; $wt = $true }

$windowTitle = $ver
if ($minprofile -and -not $PROFILEDirectory) { $windowTitle = $windowTitle + ' MP'}
$windowTitle = $windowTitle + ' - ' + $pid + ' - ' + $sessionStart
if ($admin) {$windowTitle = "[Admin] " + $WindowTitle}
Set-WindowTitle -WindowTitle $windowTitle

