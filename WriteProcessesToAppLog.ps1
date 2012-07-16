$strProcess = Get-WmiObject win32_process |
select-object name | out-string

if(![system.diagnostics.eventlog]::sourceExists("ps_script","."))
{
 $strLog = [system.diagnostics.eventlog]::CreateEventSource("ps_script","Application")
}
$strLog = new-object system.diagnostics.eventlog("application",".")
$strLog.source = "ps_script"
$strLog.writeEntry($strProcess)