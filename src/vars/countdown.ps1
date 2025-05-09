### extract the countdown potential to this file

$countdown = @(
    [PSCustomObject]@{
        PSTypeName = 'EventCountdown'
        EventName = 'DPS & GA 25'
        EventStartTime = [Datetime]::Parse("2025-05-10T00:00:00+08:00").ToUniversalTime()
        EventEndTime = [Datetime]::Parse("2025-05-11T00:00:00-07:00").ToUniversalTime()
    }
)


# Add-Countdown -EventName 'DPS & GA 25' -EventStartTime ([Datetime]::Parse("2025-05-10T00:00:00+08:00").ToUniversalTime()) -EventEndTime ([Datetime]::Parse("2025-05-11T00:00:00-07:00").ToUniversalTime()) -Force
