$strState = "stopped"
$strPath = "C:\Users\dad\scripts\StoppedServices.txt"
Get-WmiObject win32_service -filter "state='$strState'" |
select-object name |
Out-File -filePath $strPath