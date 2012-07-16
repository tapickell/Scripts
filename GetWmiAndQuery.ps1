$strClass = "usb"
Get-WmiObject -List |
Where { $_.name -like "*strClass*"  } |
ForEach-Object -begin `
     {
     Write-Host "$strClass wmi listings"
     Start-Sleep 3
     } `
-Process `
     {
      Get-wmiObject $_.name
     }