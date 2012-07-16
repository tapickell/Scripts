$args = "localhost","loopback","127.0.0.1"

foreach ($i in $args)
	{$strFile = "c:\users\dad\scripts\"+ $i +"Processes.txt"
	write-host "Testing" $i "please wait ...";
	get-wmiobject -computername $i -class win32_process |
	select-object name, processID, priority, threadcount, pagefaults, pagefileusage |
	where-object {!$_.processID -eq 0} | sort-object -property name |
	format-table | out-file $strfile}
