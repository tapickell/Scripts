$strLog = "system"
$strText = "half duplex"
Get-EventLog -LogName $strLog |
Where-Object { $_.message -match $strText }