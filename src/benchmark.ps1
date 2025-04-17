# Slightly modified version of the benchmarking script from @justin-grote
# https://gist.github.com/JustinGrote/484fcb1324f58ec359b9291b4431c962

## Reasons being
## Support powershell v5.1 and v7+
##   This was due to some v7 language features not being available in v5.1
##   Specifically the use of A pipeline at the beginning of a line
##   This was causing the script to fail in v5.1
##   Removed some icons as they aren't supported in the console host
##   Added a Switch-ProfileBenchMark function to enable/disable the benchmark
##   Added setting the environment variable to the process and user scope
##   Use True and False instead of true or empty string in the env var

## Some bits still needed for v5 support

param(
    $profilePath
)

#region functions
function Enable-ProfileBenchmark {
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', 'True', 'Process')
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', 'True', 'User')
    Write-Host -Fore Magenta 'BENCHMARKING PROFILE ENABLED. START A NEW PWSH PROCESS.'
  }
  function Disable-ProfileBenchMark {
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', 'False', 'Process')
    [Environment]::SetEnvironmentVariable('PWSH_PROFILE_BENCHMARK', 'False', 'User')
    Write-Host -Fore Magenta 'BENCHMARKING PROFILE DISABLED'
  }

  Function Switch-ProfileBenchMark {
    if ($ENV:PWSH_PROFILE_BENCHMARK -eq 'True') {
        Disable-ProfileBenchMark
        Write-Information 'DISABLED "Profile Benchmarking"'
    } else {
        Enable-ProfileBenchmark
    }
  }

#endregion functions

#region ProfileBenchmark
if ($ENV:PWSH_PROFILE_BENCHMARK -eq 'True' -and -not $ENV:PWSH_PROFILE_BENCHMARK_RUN) {
    Write-Host -Fore Magenta 'BENCHMARKING PROFILE SETUP'

    # This will ensure we don't end up in a setup loop
    Write-Host -Fore Magenta 'BENCHMARKING PROFILE'
    $profileTrace = Trace-Script -ExportPath TEMP:/pwsh-profile -ScriptBlock {
      $ENV:PWSH_PROFILE_BENCHMARK_RUN = $true
      . $profilePath
    }
    Write-Host -Fore Magenta 'BENCHMARKING PROFILE COMPLETE. Results saved to $profileTrace'
    Write-Host -Fore DarkGreen "PROFILE LOAD TIME: $([int]($profileTrace.TotalDuration.TotalMilliseconds))ms"

    Write-Host -Fore Magenta "=== PROFILE BENCHMARK TOP 10 BY DURATION ==="
    $profileTrace.Top50SelfDuration |
    Where-Object text -NE '. $PROFILE.CurrentUserAllHosts' |
    Select-Object -First 10 |
    Format-Table |
    Out-String |
    Write-Host -ForegroundColor Cyan
    Write-Host -Fore Magenta "==============================================="
    #Cleanup
    $profilePath = $null
    return
  }
#endregion ProfileBenchmark
