$aryServices = $args
foreach ($strService in $aryServices)
{
Write-Host "Starting $strService ..."
Start-Service -Name $strService
}
