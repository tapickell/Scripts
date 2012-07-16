[int]$intPing = 249
[string]$intNetwork = "192.168.1."

for ($i=1;$i -le $intPing; $i++)
{
$strQuery = "select * from win32_pingstatus where address = '" +
$intNetwork + $i + "'"
     $wmi = get-wmiobject -query $strQuery
     "Pinging $intNetwork$i ... "
     if ($wmi.statuscode -eq 0)
          {"success"}
          else
	{"error: " + $wmi.statuscode + " occurred"}
}