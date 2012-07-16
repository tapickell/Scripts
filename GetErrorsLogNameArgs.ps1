$strLog = "*$args*"
$strType = "error"

Get-EventLog $strLog |
Where-Object { $_.entryType -eq $strType }