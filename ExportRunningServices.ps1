$strState = "running"
$strPath = "$args"
Get-WmiObject win32_service -Filter "state='$strState'" |
select-object name, startmode, startname |
Export-Csv -Path $strPath