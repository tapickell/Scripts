Write-Host "Searching $strLog for Half Duplex in messages."
$strLog = $args
$strText = "half duplex"
Get-EventLog -LogName $strLog |
Where-Object { $_.message -match $strText }