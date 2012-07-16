$source = "ps_script"

if([system.diagnostics.eventlog]::sourceExists($source,"."))
{
 $log = [system.diagnostics.eventlog]::LogNameFromSourceName($source,".")
 Write-Host -ForegroundColor yellow "$source is currently registered with $log log."
 Write-Host -ForegroundColor red "$source will be deleted!!!"
 [system.diagnostics.eventlog]::DeleteEventSource($source)
}
ELSE
{ Write-Host _foregroundColor green "$source not registered" }