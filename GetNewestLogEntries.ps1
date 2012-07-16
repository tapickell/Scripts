$strLog = "application"
$intNew = 50
Get-EventLog -LogName $strLog  -newest $intNew