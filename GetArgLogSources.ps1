$strLog = "$args"
Write-Host "The following sources are registered for the $strLog log: `n"
Get-WmiObject win32_nteventlogfile -Filter "logfilename like '%$strLog%'" |
foreach { $_.sources }