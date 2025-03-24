# Slightly modified version of the benchmarking script from @justin-grote
# https://gist.github.com/JustinGrote/484fcb1324f58ec359b9291b4431c962
#region ProfileBenchmark
if ($ENV:PWSH_PROFILE_BENCHMARK -and -not $ENV:PWSH_PROFILE_BENCHMARK_RUN) {
    Write-Host -Fore Magenta '👷‍♂️ BENCHMARKING PROFILE SETUP'
    function Disable-ProfileBenchMark {
        [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', '', 'User')
        Write-Host -Fore Magenta '📈 BENCHMARKING PROFILE DISABLED'
    }

    # This will ensure we don't end up in a setup loop
    Write-Host -Fore Magenta '📈 BENCHMARKING PROFILE'
    $profilePath = $MyInvocation.MyCommand.Source
    $profileTrace = Trace-Script -ExportPath TEMP:/pwsh-profile -ScriptBlock {
      $ENV:PWSH_PROFILE_BENCHMARK_RUN = $true
      . $profilePath
    }
    Write-Host -Fore Magenta '✅ BENCHMARKING PROFILE COMPLETE. Results saved to $profileTrace'
    Write-Host -Fore DarkGreen "⏱️ PROFILE LOAD TIME: $([int]($profileTrace.TotalDuration.TotalMilliseconds))ms"

    Write-Host -Fore Magenta "=== 📈 PROFILE BENCHMARK TOP 10 BY DURATION ==="
    $profileTrace.Top50SelfDuration
    | Where-Object text -NE '. $PROFILE.CurrentUserAllHosts'
    | Select-Object -First 10
    | Format-Table
    | Out-String
    | Write-Host -ForegroundColor Cyan
    Write-Host -Fore Magenta "==============================================="
    #Cleanup
    $profilePath = $null
    return

  }
  function Enable-ProfileBenchmark {
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', 'true', 'User')
    Write-Host -Fore Magenta '📈 BENCHMARKING PROFILE ENABLED. START A NEW PWSH PROCESS.'
  }

  #endregion ProfileBenchmark

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
If ($isWindows) { Import-Module BetterCredentials -Prefix b }
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

#region prompt
. $PSScriptRoot\prompt.ps1
#endregion prompt


# if ($isWindows -and ($host.Name -match 'ConsoleHost') -and ($wt)) {
#     # Set-Location C:\ # Have commented this out as this breaks the Open In Terminal right click Explorer option
# }
#

# region psreadline
. $PSScriptRoot\PSReadLineConfig.ps1
# endregion psreadline

# region windows
if ($isWindows) {
    . $PSScriptRoot\windows.ps1
}
# endregion windows

# region linux
if ($IsLinux) {
    . $PSScriptRoot\linux.ps1
}
# endregion linux

# region macos
if ($IsMacOS) {
    . $PSScriptRoot\macos.ps1
}
# endregion macos

# SIG # Begin signature block
# MIIFuQYJKoZIhvcNAQcCoIIFqjCCBaYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA4DKVEh+ex4R/r
# ZcIy6NAje9zZxZ3wd4V6N/AVmBGRSKCCAyIwggMeMIICBqADAgECAhBkETpvhrQB
# o0gIqlOM4f4AMA0GCSqGSIb3DQEBCwUAMCcxJTAjBgNVBAMMHFBvd2VyU2hlbGwg
# Q29kZSBTaWduaW5nIENlcnQwHhcNMjUwMzIzMTU1MjE4WhcNMjYwMzIzMTYxMjE4
# WjAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwYSKq8XULNJU3hq0GeOZw8s4U5EH
# EUfbCl516NqVJn1UXhVdLKGI4XhKazgiZ2lAw3C6jUPyQY/kz/ajw8G38nhPvtkH
# pUiuCZas7hZleZW2pMIrMxBf5mNjFtV2aVszUaDh1ajWSK82rPjD2W2h85fIQ36e
# VRYNkOV1cL+2YO3br+23Rc7vdIgwAo5HYPoV4G5E1550cfw7Tz4lu+zdpP+SEfbP
# Khkv4eZJNalHoXzZztk4bt0cLrfvyVE/w2ii//AwviNX/R28hehFyqB99lX6E89T
# JXe9yqIQelqQKtSigi5jqihdyWjlu54j/gUu+6NSwqPRmzyF2fTdEBQSXQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFHsX0NB+1UF0Z70FV0VzHM5NSRwEMA0GCSqGSIb3DQEBCwUAA4IBAQAY4Baa
# p6KAv63nS4WXUdYAAXltSCqbjx86UtFnBNTLIWN6GMGV6rhfMwiNNkV3152TBs2t
# gw+JBvKnvkQpsozRq4fxxFir7fn1W8kwTfFOo4Fy/5hjhH0/Ndo+Hog20Hdvv3Hz
# yaLgA95RvoI+tFIIU8hTC6/efOu7wQoTTQR40uLXb2frulJVkCy4EEuYBhDlWT6I
# YTnUkr6litYRkquCIgLvGYf2j9ZQE1S8ISgBPPLfwZyDzICI01FfGSPvtO7WOZ9q
# cxbLDec43kFFcHf2SGi7dW0We3MeIzPu8Y4phvgGGCYXflqN++iK/UdVKON2DCsG
# oJ1rl1JS9kyix5PUMYIB7TCCAekCAQEwOzAnMSUwIwYDVQQDDBxQb3dlclNoZWxs
# IENvZGUgU2lnbmluZyBDZXJ0AhBkETpvhrQBo0gIqlOM4f4AMA0GCWCGSAFlAwQC
# AQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZI
# hvcNAQkEMSIEIH8QkqaiXHAMsUXKTWrLmVUBw9ngeqOFYZeK39y2i4qnMA0GCSqG
# SIb3DQEBAQUABIIBAFGUcjpB/DNmkGKMUkXzd4Ikoo20BkRxdnINf2QCnGRhumxd
# xsO/D+CgVcDNwzDdSED8UoPdj1HUhqtnIqp8Q3aMOEk0lK4JfwU9KD1vxkkX0QSw
# o1uTITC4vi2DZO7Haaj9YRS3waveV80tdtntBcxqlMtyLURGuHQNsBOZuq6+U2LW
# wtTiIzZceNSNdqhKV/egVtbFIVBgQ8rCuUVkEVx7jCWG62OwSkQEjXyC0Py3uEqb
# 6ihUpAygmn2Jx6i3cyZ6jiU1bBdv36lBjwE7U7PljPVn2W44BdR+va5T6gRzZpaq
# IqkmSDz8py3YL6WvMszwuQDRUSAVjFnV7zFIbVQ=
# SIG # End signature block
