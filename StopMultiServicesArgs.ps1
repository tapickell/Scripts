$aryServices = $args
foreach ($strService in $aryServices)
{
Write-Host "Stopping $strService ..."
Stop-Service -Name $strService
}
