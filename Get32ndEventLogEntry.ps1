Write-Host " The following is the 32nd error in the log"
(Get-EventLog application)[31] | Format-List