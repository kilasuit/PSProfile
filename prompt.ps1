param([switch]$minprofile)


function global:prompt {
    if ($Admin) {
        Write-Host "[ADMIN]" -ForegroundColor Red -NoNewline
    }
    Write-Host "[ $(Get-Date -Format "HH:mm:ss") ] " -ForegroundColor Yellow -NoNewline
    Write-Host "[ $((Get-Location).path) ] " -NoNewline -ForegroundColor Blue
    $duration = $((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime)
    if ($minprofile) { Write-Host "[ $duration ] " -NoNewline -ForegroundColor Gray }
    else {
        Write-Host "[ $($duration.Humanize(3)) ]" -NoNewline -ForegroundColor Gray
    }
    if ((Get-Process -Id $pid).Parent -notmatch 'Code') {
        if (Get-Module Posh-git) { Write-VcsStatus } 
    }
    Write-Host ' '
    "$((Get-History)[-1].ID) > "
}