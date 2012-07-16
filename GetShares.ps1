if($args)
{
	$type = $args
	get-wmiobject win32_share -filter "type = $type"
}
else
{
	write-host
	"
	Using default values, file shares type = 0.
	Other valid types are:
	2147483648 for disk drive admin share
	2147483649 for print queue admin share
	2147483650 for device admin share
	2147483651 for ipc$ admin share
	Example: c:\GetsShares.ps1 '2147483651'
	"
	$type = '0'
	Get-WmiObject win32_share -Filter "type = $type"
}
