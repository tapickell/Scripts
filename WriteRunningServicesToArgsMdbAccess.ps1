$StrComputer = (New-Object -ComObject WScript.Network).computername
$strDomain = (New-Object -ComObject WScript.Network).Domain
$strWMIQuery = "Select * from win32_Service"
$objservice = get-wmiobject -query $strWMIQuery

Write-Host -ForegroundColor yellow "Obtaining service info ..."

foreach ($service in $objService)
 {
   if ($service.state -eq "running")
     {
	$strServiceName = $service.name
	$strStatus = $service.state
	$adOpenStatic = 3
	$adLockOptimistic = 3
	$strDB = "$args"
	$strTable = "runningServices"
	$objConnection = New-Object -ComObject ADODB.Connection
	$objRecordSet = New-Object -ComObject ADODB.Recordset
	$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
	    Data Source = $strDB")
	$objRecordSet.Open("SELECT * FROM Running Services", `
	    $objConnection, $adOpenStatic, $adLockOptimistic)
	$objRecordSet.Fields.item("TimeStamp") = Get-Date
	$objRecordSet.Fields.item("strComputer") = $strComputer
	$objRecordSet.Fields.item("strDomain") = $strDomain
	$objRecordSet.Fields.item("strService") = $strServiceName
	$objRecordSet.Fields.item("strSatus") = $strStatus
	$objRecordSet.Update()
	Write-Host -ForegroundColor green "/\" -noNewLine
        }
   }
$objRecordSet.Close()
$objConnection.Close()