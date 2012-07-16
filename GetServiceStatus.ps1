Get-Service |
Sort-Object status -descending |
foreach {
     if ( $_.status -eq "stopped")
     {Write-Host $_.name $_.status -ForegroundColor red}
     elseif ( $_.status -eq "running" )
     {Write-Host $_.name $_.status -ForegroundColor green}
     else
     {Write-Host $_.name $_.status _ForegroundColor yellow}
}