Get-WmiObject win32_usbhub |
foreach-object `
-begin { Write-Host "Usb Hubs on:" $(Get-Item env:\computerName).value } `
-process { $_.pnpDeviceID} `
-end { Write-Host "The command completed at $(get-date)" }