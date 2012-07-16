$aryService = $args

foreach($strService in $aryService)
{
Write-Host "Service Info for: $strService"
Get-Service -Name $strService | Format-list *
}
