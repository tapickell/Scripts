$strProcess = Get-WmiObject win32_process |
	select-object name | out-string
$source = "ps_script"
$log = "PS_Script_Log"

if(![system.diagnostics.eventlog]::sourceExists($source,"."))
{
  [system.diagnostics.eventlog]::CreateEventSource($source,$log)
}
ELSE
{
Write-Host -ForegroundColor red "$source is already registered with another event Log"
EXIT
}$strLog = new-object system.diagnostics.eventlog($log,".")
$strLog.source = $source
$strLog.writeEntry($strProcess)