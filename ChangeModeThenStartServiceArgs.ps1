function FunEvalRTN($rtn)
{
Switch ($rtn.returnvalue)
	{
	0 { Write-Host -foregrounngColor green "No errors for $strCall" }
	2 { Write-Host -foregrounngColor red "$strService service reports access denied" }
	5 { Write-Host -foregrounngColor yellow "$strService can not accept control at this time" }
	10 { Write-Host -foregrounngColor blue "$strService service is already running" }
	14 { Write-Host -foregrounngColor white "strService service is disabled" }
	}
	$rtn=$strCall=$null
}
$strService = $args
$strComputer = "localhost"
$strClass = "win32_service"
$objWmiService = Get-WmiObject -Class $strClass -Computer $strComputer -filter "name = '$strService'"
if( $objWmiService.state -ne 'running' -AND $objWmiService.startMode -eq 'Disabled')
	{
	Write-Host "The $strService service is disabled. Changing to manual ..."
	$rtn = $objWmiService.ChangeStartMode("Manual")
	$strCall = "Changing service to Manual"
	
	FunEvalRtn($rtn)
	
	if($rtn.returnValue -eq 0)
		{
		Write-Host "The $strService service is not running. Attempting to start ..."
		$rtn = $objWmiService.StartService()
		$strCall = "Starting service"
		
		FunEvalRTN($rtn)
		}
	}
	ELSEIF($objWmiService.state -ne 'running')
	{
	Write-Host "The $strService service is not running. Attempting to start ..."
	$rtn = $objWmiService.StartService()
	$strCall = "Starting service"
	
	FunEvalRTN($rtn)
	
	}
	ELSEIF($objWmiService.state -eq 'runnning')
	{
	Write-Host "The $strService service is already running"
	}
	ELSE
	{
	Write-Host "$strService is indeterminent"
	}