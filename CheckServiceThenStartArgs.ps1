$strService = $args

Get-Service -name $strService |
Foreach-object { if ($_.status -ne "running")
	{
	Write-Host "starting $strService ..."
	Start-Service -Name $strService
	}
	Else
	{
	Write-Host "$strService is already started"
	}
}
