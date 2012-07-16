$StrComputer = (New-Object -ComObject WScript.Network).computername
$StrDomain = (New-Object -ComObject WScript.Network).Domain
$StrWMIQuery = "Select * from win32_Service"
$objservice = get-wmiobject -query $StrWMIQuery

write-host -foreGroundColor yellow "Obtaining service info ...."

foreach ($service in $objService)
{
$strServiceName = $service.name
$strStartName = $service.StartName
$strStartMode = $service.StartMode
$blnAcceptPause = $service.AcceptPause
$blnAcceptStop = $service.AcceptStop
$adOpenStatic = 3
$adLockOptimistic = 3
$strDB = "c:\fso\services.mdb"
$strTable = "ServiceConfiguration"
$strAccessQuery = "Select * from $strTable"
$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = New-Object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
   Data Source = $strDB")
$objRecordSet.Open($strAccessQuery, `
   $objConnection, $adOpenStatic, $adLocjOptimistic)

$objRecordSet.AddNew()
$objRecordSet.Fields.item("TimeStamp") = Get-Date
$objRecordSet.Fields.item("strComputer") = $strComputer
$objRecordSet.Fields.item("strDomian") = $strDomain
$objRecordSet.Fields.item("strService") = $strServiceName
$objRecordSet.Fields.item("strStartName") = $strStartName
$objRecordSet.Fields.item("strStartMode") = $strStartMode
$objRecordSet.Fields.item("blnAccpetPause") = $blnAccpetPause
$objRecordSet.Fields.item("blnAcceptStop") = $blnAcceptStop
$objRecordSet.Update()
write-host -foreGroundColor green "/\" -noNewLine
}

$objRecordSet.CLose()
$objConnection.Close()
