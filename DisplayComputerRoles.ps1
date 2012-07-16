$wmi = get-wmiobject win32_computersystem
"computer " + $wmi.name + " is: "
switch ($wmi.domainrole)
	{
	0 {"`t Stand alone workstation"}
	1 {"`t Member workstation"}
	2{"`t Stand alone server"}
	3 {"`t Member server"}
	4 {"`t Back up domain controller"}
	5 {"`t Primary domain controller"}
	default {"`t The role can not be determined"}
}