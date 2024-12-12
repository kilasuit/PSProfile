Set-PSReadLineKeyHandler -Chord F8 -Function ViEditVisually

if ($PSVersionTable.PSVersion.Major -match 5) {
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
    If (-not ((Get-ScheduledJob).Name -contains 'PwshDaily') -and ($admin -eq $true)) {

        Write-Verbose 'Registing Daily PowerShell Download Job' -Verbose
        Register-ScheduledJob -Name PwshDaily -Trigger (New-JobTrigger -Daily -At "19:00 PM") -ScriptBlock {
            # Get version from currently installed PowerShell Daily if available.# Get version from currently installed PowerShell Daily if available.
            $version = if (Test-Path C:\ps-daily\pwsh.exe) {
                (( & C:\ps-daily\pwsh.exe -version) -split " ")[1]
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
}