$aryLogs = Get-EventLog -List
$intNew = 5
foreach ($strLog in $aryLogs)
{
     Write-Host -ForegroundColor green `
	"
	 $($strLog.log) Log Newest $intNew entries
	"
     Get-EventLog -LogName $strLog.log -newest $intNew
}