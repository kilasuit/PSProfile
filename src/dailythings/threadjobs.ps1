Start-ThreadJob -Name UpdateHelp {Update-Help -force}
# Start-ThreadJob -Name ModulesToUpdate {Update-PSResource -force}
# Start-ThreadJob -Name AppsToUpdate {Get-WinGetPackage | Where IsUpdateAvailable}
# Start-ThreadJob -Name RemoteMachineAppsToUpdate {Invoke-Command -Session $Sessions { Get-WinGetPackage | Where IsUpdateAvailable} }
