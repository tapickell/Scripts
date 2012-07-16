function DisplayLogSettings()
{
Write-Host `
"
The current settings on the $($objLog.LogDisplayName) file are:
max Kilobytes: $($objLog.maximumKiloBytes)
min retention days: $($objLog.minimumRetentionDays)
overflow policy: $($objLog.overFlowAction)
"
 if (!$args) { ChangeLogSettings("help") }
}

function ChangeLogSettings($policy)
{ if($policy -ne "help")
     {
      Write-Host -ForegroungColor green "changing log policy ..."
     }
switch($policy)
     {
      "doNotOW"	{ $objlog.modifyoverflowpolicy("DoNotOverwrite",-1) }
      "owAsNeeded"	{ $objlog.modifyoverflowpolicy("OverwriteAsNeeded",-1) }
      "owOlder"	{ $objlog.modifyoverflowpolicy("Overwriteolder",$intRetention) } 
      DEFAULT	{
		 Write-Host -ForegroundColor red `
		  "
		You need to specify either of the following: `n
		doNotOW - do not overwrite logs
		owAsNeeded - overwrite as needed
		owOlder - overwrite events longer than $intRetention days `n
		Example: > SetEventLogRetentionPolicy.ps1 doNotOW
			   Sets retention policy to Do Not Overwrite		

		Example: > SetEventLogRetentionPolicy.ps1 owAsNeeded
			   Sets retention policy to overwrite as needed

		Example: > SetEventLogRetentionPolicy.ps1 owOlder
			   Sets retention policy to Overwrite older than 30 days

		Example: > SetEventLogRetentionPolicy.ps1 help
			   Displays this help message
		"
	exit		}
 }
}

$strLog = "application" #modify for different log
$intRetention = 30 #modify for different number of retention days
$objLog = New-Object system.diagnostics.eventLog("$strLog")

DisplayLogSettings($args)
ChangeLogSettings($args)
DisplayLogSettings($args)