$strService = $args
Get-WmiObject win32_service -filter "name = '$strService'" | fl [a-z]*