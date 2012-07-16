$strFile = "C:\Users\dad\scripts\StoppedServices.txt"
Get-Content $strFile |
foreach-object { $strService = $_.trimend()
$strQuery = "Select * from win32_service where name = '$strService'"
Get-WmiObject -query $strQuery |
foreach-object `
{
if ($_.state -eq "stopped")
{ Write-Host $_.name "is still stopped" }
ELSE
{ Write-Host -foregroundColor RED $_.name `
	"is no longer stopped. It is $($_.state)"}
}
}
