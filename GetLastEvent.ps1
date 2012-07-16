Write-Host "the following is the latest error in the log"
(Get-EventLog application)[0] | Format-List