$a = ipconfig /all

switch -wildcard ($a)
  {
     "*DHCP Server*" { Write-Host $switch.current }
  }