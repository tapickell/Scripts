$strProcess = "system"
Get-Process |
foreach ( $_.name ) {
     if ( $_.name -eq $strProcess )
     {
          Write-Host "system process is ID : " $_.ID
     }
}
