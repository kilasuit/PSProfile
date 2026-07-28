param([switch]$minprofile)



    function global:prompt {
        $RunningJobs = (Get-Job -State Running).Count
        $CompletedJobs = (Get-Job -State Completed).Count
        $FailedJobs = (Get-Job -State Failed).Count
        # Comeback to as this is not working as expected
        # $otherJobs = (Get-Job | where State -Match "NotStarted|Stopped|Blocked|Suspended|Disconnected|Suspending|Stopping|AtBreakpoint" ).Count

        # See issue 17 for more info on this below line not working as expected however is fixed with the elseif statement below
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
                    $((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Humanize(3).Replace('days', 'd').Replace('hours', 'h').Replace('hour', 'h').Replace('minutes', 'm').Replace('minute', 'm').Replace('milliseconds', 'ms').Replace('millisecond', 'ms').Replace('seconds', 's').Replace('second', 's')
                }
            }
        }
        elseif ($minprofile) {
            $history = [PSCustomObject]@{
                ID       = 1
                Duration = '0 ms'
            }
        }
        else {
            $history = [PSCustomObject]@{
                ID       = 1
                Duration = '0 s'
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
        Write-Host "[$(Get-Date -Format "ddd")]" -ForegroundColor Magenta -NoNewline
        # 28 July 2026 - Added this cos why not - I like to see the day of the week hence making changes as detailed below for the taskbar showing the day as well.

        Write-Host "[$(Get-Date -Format "yy-MM-dd")]" -ForegroundColor Green -NoNewline <#
        28th July 2026 -
        This broke on L-T14 after having changed Short Date format via the Date & Time Control Panel & via Settings menu. It should output with the /  however no longer does & I CBA to diagnose why this is. FWIW, the setting I was changing was so that on my taskbar I get the the following
            Tue 28/07/2026

            Write-Host "[$(Get-Date -Format "yy/MM/dd")]" -ForegroundColor Green -NoNewline
        #>
        Write-Host "[$(Get-Date -Format "HH:mm:ss")]" -ForegroundColor Yellow -NoNewline
        Write-Host "[$($pwd.path)]" -NoNewline -ForegroundColor Blue
        # Comeback to building a $promptConfig in future -  if ($promptConfig.ShowPath) { }
        Write-Host "[$($History.duration)]" -NoNewline -ForegroundColor Gray

        ### Add the following to the prompt if you want to show the number of jobs running and completed
        if ($RunningJobs){Write-Host "[RunningJobs - $RunningJobs]" -NoNewline -ForegroundColor Yellow}
        if ($CompletedJobs){Write-Host "[CompletedJobs - $CompletedJobs]" -NoNewline -ForegroundColor Green}
        if ($FailedJobs){Write-Host "[FailedJobs - $FailedJobs]" -NoNewline -ForegroundColor Red}
        if ($otherJobs.Count -ge 1) {
            Write-Host "[OtherJobs - $otherJobs]" -NoNewline -ForegroundColor Gray
        }
    if ((Get-Process -Id $pid).Parent -notmatch 'Code') {
        if (-not $noGit) {
            if (Get-Module Posh-git) { Write-Host (Write-VcsStatus) -NoNewline } # This is added in this way to prevent adding the output on a newline
        }
    }
        if ($countdown.count -ge 1) {
            $countdown = $countdown | Foreach {
                Write-Host ' '
                Write-Countdown -EventName $countdown.EventName -EventStartTime $countdown.EventStartTime -EventEndTime $countdown.EventEndTime
            }
        }
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
