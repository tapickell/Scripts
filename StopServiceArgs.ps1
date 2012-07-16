$strService = $args
Write-Host "Stopping $strService ..."
Stop-Service -Name $strService