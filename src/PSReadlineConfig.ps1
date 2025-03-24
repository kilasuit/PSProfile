## Can't remember why this was in here
# Set-PSReadLineKeyHandler -Chord F8 -Function ViEditVisually

Remove-PSReadLineKeyHandler Ctrl+Enter

if ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -gt 2) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    if ((Get-Process -Id $Pid).Parent -notmatch 'Code') {
        Set-PSReadLineOption -PredictionViewStyle ListView
    }
}

if ($PSVersionTable.PSVersion.Major -match 5) {
## I used this way back before that was default in PSReadLine
    Set-PSReadLineOption -AddToHistoryHandler {
    param([string]$line)

    $sensitive = "password|asplaintext|token|key|secret"

    If ($line -match $sensitive) {
        # try and sanitise full command
        $linestart = $($line -split ' ')[0]

    }

    return ($line -notmatch $sensitive)
}

    Write-Host 'Why you in PowerShell 5 - go into 7'
    <#
    This used to be used when we had daily builds of PowerShell
    If (-not ((Get-ScheduledJob).Name -contains 'PwshDaily') -and ($admin -eq $true)) {

        Write-Verbose 'Registering Daily PowerShell Download Job' -Verbose
        Register-ScheduledJob -Name PwshDaily -Trigger (New-JobTrigger -Daily -At "19:00 PM") -ScriptBlock {
            # Get version from currently installed PowerShell Daily if available.# Get version from currently installed PowerShell Daily if available.

            $version = if (Test-Path C:\ps-daily\pwsh.exe) {
                (( & C:\ps-daily\pwsh.exe -version) -split " ")[1]
            } elseif (Test-Path $env:LOCALAPPDATA\Microsoft\powershell-daily\pwsh.exe) {
                (( & $env:LOCALAPPDATA\Microsoft\powershell-daily\pwsh.exe -version) -split " ")[1]
            } else {
                "0.0.0"
            }
            # Grab latest daily version
            try {
                $metadata = (Invoke-RestMethod https://pscoretestdata.blob.core.windows.net/buildinfo/daily.json).ReleaseTag.TrimStart("v")
            }
            catch {
                # If we couldn't get the latest daily version, just return. This is probably a network issue.
                return
            }

            if ($version -ne $metadata) {
                Invoke-Expression "& {$(Invoke-RestMethod aka.ms/install-powershell.ps1)} -Daily -Destination C:\ps"
            }
            else {
                Write-Verbose "Latest PowerShell Daily already installed." -Verbose
            }

        } | Out-Null
    }
    #>
}
