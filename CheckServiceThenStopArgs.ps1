$strService = $args
$strComputer = "localhost"
$strClass = "win32_service"
$objWmiService = Get-WmiObject -Class $strClass -computer $strComputer -filter "name = '$strService'"
if( $objWMIService.AcceptStop )
{
	Write-Host "Stopping the $strService service now ..."
	$rtn = $objWMIService.stopService()
	Switch ($rtn.returnvalue)
		{
			0 { Write-Host -ForegroudColor green "$strService stopped" }
			2 { Write-Host -ForegroudColor red "$strService service reports access denied" }
			5 { Write-Host -ForegroudColor red "$strService service cannot accept control at this time" }
			10 { Write-Host -ForegroudColor red "$strService service is already stopped" }
			DEFAULT { Write-Host -ForegroudColor yellow "$strService service reports ERROR $($rtn.returnvalue)" }
		}
}
ELSE
{
Write-Host "$strService will not accept stop request"
}
