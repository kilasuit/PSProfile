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
            $stable = $releaseApi | Where-Object prerelease -Match 'false' | Where-Object tag_name -Match '7.5' | Select-Object -First 1
            $lts = $releaseApi | Where-Object prerelease -Match 'false' | Where-Object tag_name -Match '7.4' | Select-Object -First 1
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
