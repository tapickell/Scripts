$strPattern = "version"
$text = net config workstation

switch -regex ($text)
{
$strPattern { Write-Host $switch.current }
}
