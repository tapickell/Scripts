$aryComputers = "loopback", "localhost"
Set-variable -name intDriveType -value 3 -option constant

foreach ($strComputer in $aryComputers)

	{"Hard drives on: " + $strComputer
	Get-WmiObject -class win32_logicaldisk -computernam $strComputer | Where {$_.drivetype -eq $intDriveType}
	}