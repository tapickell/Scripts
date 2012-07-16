$strLog = "$args"
$objLog = New-Object system.diagnostics.eventLog("$strLog")

Write-Host `
"
The current settings on the $($objlog.logDisplayName) file are:
max kilobytes: $($objLog.MaximumKiloBytes)
min retention days: $($objLog.minimumRetentionDays)
overflow policy: $($objLog.overFlowAction)
"