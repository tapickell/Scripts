$strLog = "Microsoft-Windows-EventLog-WMIProvider/Debug"
switch -wildcard (wevtutil gl $strLog)
     {
	"*enabled*" { $switch.Current }
     }