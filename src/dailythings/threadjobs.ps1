if ([DateTime]::Now.DayOfWeek -eq 'Monday' -and [System.Environment]::GetEnvironmentVariable('UpdateHelp','User') -ne (get-date -Format "yyyyMMdd")) {
    Start-ThreadJob -Name UpdateHelp {Update-Help -force; [System.Environment]::SetEnvironmentVariable("UpdateHelp", (get-date -Format "yyyyMMdd"), [System.EnvironmentVariableTarget]::User)}
}
# Start-ThreadJob -Name ModulesToUpdate {Update-PSResource -force}
# Start-ThreadJob -Name AppsToUpdate {Get-WinGetPackage | Where IsUpdateAvailable}
# Start-ThreadJob -Name RemoteMachineAppsToUpdate {Invoke-Command -Session $Sessions { Get-WinGetPackage | Where IsUpdateAvailable} }
