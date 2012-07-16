$strPath = "C:\Users\dad\scripts\dcm1.txt"
Get-Service |
format-table name, status -autosize |
Out-File -FilePath $strPath