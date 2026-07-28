function Write-Countdown {
    param(
        [string]$eventName,
        [datetime]$eventStartTime,
        [datetime]$eventEndTime
    )

    $eventStartTime = $eventStartTime -as [datetime]
    $eventEndTime = $eventEndTime -as [datetime]
    $eventDuration = $eventEndTime - $eventStartTime  # Remove spaces for better formatting
    $startCountDown = ($eventStartTime - (Get-Date)).Humanize(3).Replace('days', 'd').Replace('hours', 'h').Replace('hour', 'h').Replace('minutes', 'm').Replace('minute', 'm').Replace('milliseconds', 'ms').Replace('millisecond', 'ms').Replace('seconds', 's').Replace('second', 's').replace(' ','')
    $finishCountdown = ($eventEndTime - (Get-Date)).Humanize(3).Replace('days', 'd').Replace('hours', 'h').Replace('hour', 'h').Replace('minutes', 'm').Replace('minute', 'm').Replace('milliseconds', 'ms').Replace('millisecond', 'ms').Replace('seconds', 's').Replace('second', 's').replace(' ','')
    if ($startCountDown -gt 0) {
    $message = "[$eventName - Starts in $startCountDown & is scheduled for $($eventDuration.TotalHours) hours]"
    }
    else {
        $message = "[$eventName - Finishes in $($finishCountDown.Humanize())]"
    }
    Write-host $message
}
