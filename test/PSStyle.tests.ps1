$DebugPreference = "Continue"
$WarningPreference = "Continue"


if ($PSStyle.Formatting.Debug -ne "`e[38;2;255;140;0m") {
        "Debug colour is not set correctly" }
    else {
        Write-Debug "Debug colour is set correctly"
    }

if ($PSStyle.Formatting.Warning -ne "`e[95m") {
        "Warning colour is not set correctly" }
    else {
        Write-Warning "Warning colour is set correctly"
    }

$DebugPreference = "SilentlyContinue"
$WarningPreference = "SilentlyContinue"
