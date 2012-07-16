switch -regex (${c:\users\dad\scripts\testa.txt})
{
'test' {Write-Host $switch.current}
'good' {Write-Host $switch.current}
}