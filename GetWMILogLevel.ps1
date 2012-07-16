Write-Host "The WMI logging level is:
$((Get-WmiObject win32_wmisetting).logginglevel)"