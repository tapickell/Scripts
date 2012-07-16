$strLog = "c:\Users\dad\scripts\applog.txt"
$e=$i=$w=0

switch -wildcard -file $strLog {
"*error*" { $e++ }
"*info*" {$i++ }
"*warn*" { $w++ }
}
Write-Output "
$strLog contains the following:
	errors		$e
	warnings	$w
	information	$i
"
