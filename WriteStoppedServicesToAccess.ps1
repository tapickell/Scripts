$StrComputer = (New-Object -ComObject WScript.Network).computername
$StrDomain = (New-Object -ComObject WScript.Network).Domain
$StrWMIQuery = "Select * from win32_Service"
$objservice = get-wmiobject -query $StrWMIQuery

Write-Host -ForegroundColor yellow "Obtaining service info ..."

foreach ($service in $ObjService)
   {
       if ($service.state -eq "stopped")
	{
	  $StrServiceName = $service.name
	  $StrStatus = $service.State
	  $adOpenStatic = 3
	  $adLockOptimistic = 3
	  $strDB = "c:\fso\services.mdb"
	  $strTable = "StoppedServices"
	  $objConnection = New-Object -ComObject ADODB.Connection
	  $objRecordSet = New-Object -ComObject ADODB.RecordSet
	  $objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
		Data Source= $strDB")
	  $objRecordSet.Open("SELECT * FROM Stopped Services", `
		$objConnection, $adOpenStatic, $adLockOptimistic)

	  $objRedcordSet.AddNew()
	  $objRecordSet.Fields.item("TimeStamp") = Get-Date
	  $objRecordSet.Fields.item("strComputer") = $strComputer
	  $objRecordSet.Fields.item("strDomain") = $strDomain
	  $objRecordSet.Fields.item("strService") = $strServiceName
	  $objRecordSet.Fields.item("strStatus") = $strStatus
	  $objRecordSet.Update()
	  Write-Host -ForegroundColor blue "/\" -noiNewLine
	}
         }
$objRecordSet.Close()
$objConnection.Close()