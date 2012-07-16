$strType = "*$args*"
Get-EventLog application | 
Where-Object { $_.source -like $strType }