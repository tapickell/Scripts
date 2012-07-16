$wmiLog = Get-WmiObject win32_WMISetting
$wmiLog.logginglevel = 1
$wmiLog.put()