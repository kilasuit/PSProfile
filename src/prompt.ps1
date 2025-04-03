param([switch]$minprofile)

$script:wingetLastRun = Get-Date
function Get-PSWingetStatus {
    [cmdletbinding()]
    param (
        [Parameter()]
        [datetime]
        $lastRun = $wingetLastRun,

        [Parameter()]
        [switch]
        $UseReleasesPageInfo
    )

    # Most would do this after runinin this function
    $script:wingetLastRun = $now = [datetime]::Now
    if ($now.Minute -gt $lastRun.AddMinutes(1).Minute) {
        If ($UseReleasesPageInfo) {
            $releaseApi = Invoke-RestMethod https://api.github.com/repos/PowerShell/PowerShell/releases -Verbose:$false
            $Preview = $releaseApi | Where-Object prerelease -Match 'true' | Select-Object -First 1 -Property tag_name, assets_url, prerelease
            $stable = $releaseApi | Where-Object prerelease -Match 'false' | Where-Object tag_name -Match '7.4' | Select-Object -First 1
            $lts = $releaseApi | Where-Object prerelease -Match 'false' | Where-Object tag_name -Match '7.2' | Select-Object -First 1
            $bothLts = $stable, $lts
            $bothLts.ForEach{ $_ | Select-Object -Property tag_name, assets -ExpandProperty assets }
        }
        else {
            $releaseVersions = Invoke-RestMethod https://raw.githubusercontent.com/PowerShell/PowerShell/refs/heads/master/tools/metadata.json -Verbose:$true
            $Preview = (Find-WinGetPackage -Id Microsoft.PowerShell.Preview | Where-Object Name -NotMatch preview).Version -match $releaseVersions.PreviewReleaseTag
            $Stable = (Find-WinGetPackage - Microsoft.PowerShell | Where-Object Name -NotMatch preview).Version -match $releaseVersions.StableReleaseTag
            Write-Output "Stable - $stable, Preview - $preview"
        }
    }
}

    function global:prompt {
        $RunningJobs = (Get-Job -State Running).Count
        $CompletedJobs = (Get-Job -State Completed).Count
        $FailedJobs = (Get-Job -State Failed).Count
        $otherJobs = (Get-Job| where State -NotMatch 'Completed|Failed|Running').Count
        if ((Get-History).Count -gt 1) {
            $history = [PSCustomObject]@{
                ID       = (Get-History)[-1].ID + 1
                Duration = if ($minprofile) {
                    $((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime)
                }
                else {
                    # This super long replace is only because in the PowerShell Humanizer Module (as well as in Humanizer .Net library) they don't yet shorten further
                    # I have some on going work that I am doing for this in Humanizer & may even fork it and publish it myself
                    # However in Pwsh we are likely to try and add this to PSStyle soon so this is a temporary measure.
                    $((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Humanize(3).Replace('days', 'd').Replace('hours', 'h').Replace('hour', 'h').Replace('minutes', 'm').Replace('minute', 'm').Replace('milliseconds', 'ms').Replace('seconds', 's').Replace('second', 's')
                }
            }
        }
        else {
            $history = [PSCustomObject]@{
                ID       = 1
                Duration = '0 ms'
            }
        }
        #     # update my path section to simplify this & only show full path if not in a PSDrive
        # if $pwd.path.Split([System.IO.Path]::DirectorySeparatorChar)

        #     switch {
        #     PRI = {}
        # }
        if ($Admin) {
            Write-Host "[" -NoNewline -ForegroundColor DarkGray
            Write-Host "Admin" -NoNewline -ForegroundColor Red
            Write-Host "]" -NoNewline -ForegroundColor DarkGray
        }
        Write-Host "[$(Get-Date -Format "HH:mm:ss")]" -ForegroundColor Yellow -NoNewline
        Write-Host "[$($pwd.path)]" -NoNewline -ForegroundColor Blue
        # Comeback to building a $promptConfig in future -  if ($promptConfig.ShowPath) { }
        Write-Host "[$($History.duration)]" -NoNewline -ForegroundColor Gray

        ### Add the following to the prompt if you want to show the number of jobs running and completed
        if ($RunningJobs){Write-Host "[RunningJobs - $RunningJobs]" -NoNewline -ForegroundColor Yellow}
        if ($CompletedJobs){Write-Host "[CompletedJobs - $CompletedJobs]" -NoNewline -ForegroundColor Green}
        if ($FailedJobs){Write-Host "[FailedJobs - $FailedJobs]" -NoNewline -ForegroundColor Red}
        if ($otherJobs.Count -gt 0) {
            Write-Host "[OtherJobs - $otherJobs]" -NoNewline -ForegroundColor Gray
        }
    if ((Get-Process -Id $pid).Parent -notmatch 'Code') {
        if (-not $noGit) {
            if (Get-Module Posh-git) { Write-Host (Write-VcsStatus) -NoNewline } # This is added in this way to prevent adding the output on a newline
        }
    }
        # if ($countdown) {
        #     Write-Countdown
        # }
        Write-Host ' '
        "$($history.ID) > "
    }


#region preprompt
# This is a function that I have used in the past very breifly in updating the WindowTitle
# prior to executing a scriptblock - this is not currently in use but is here for reference
# and may be used in the future
# see Feature Request - "pre" execution functionality - https://github.com/PowerShell/PowerShell/issues/14484
#
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
