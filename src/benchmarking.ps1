# Slightly modified version of the benchmarking script from @justin-grote
# https://gist.github.com/JustinGrote/484fcb1324f58ec359b9291b4431c962
#region ProfileBenchmark
if ($ENV:PWSH_PROFILE_BENCHMARK -and -not $ENV:PWSH_PROFILE_BENCHMARK_RUN) {
    Write-Host -Fore Magenta '👷‍♂️ BENCHMARKING PROFILE SETUP'

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
  function Disable-ProfileBenchMark {
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', '', 'User')
    Write-Host -Fore Magenta '📈 BENCHMARKING PROFILE DISABLED'
  }
  #endregion ProfileBenchmark
