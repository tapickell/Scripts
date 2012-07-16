Write-Host "The following is the first error in the log"
(Get-EventLog application)[(Get-EventLog application).length-1] | Format-List