Get-WmiObject -Class win32_service |
Where-Object { $_.acceptpause -eq "true" } |
Select-Object name