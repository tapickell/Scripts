$strState = "running"
$strPath = "$args"
Get-Service |
Where-Object { $_.status -eq $strState } |
Out-File -FilePath $strPath