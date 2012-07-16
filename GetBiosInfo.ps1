#This code demonstrates how to list Computer System BIOS information for the local system 
#without any plug-ins. 
#
#To run this script within your environment you should only need to copy and paste this script into
#either Windows Powershell ISE or PowerGUI Script Editor,(http://powergui.org) with the following
#changes to the script which I have numbered below.  
#  1.) You may also need to install Microsoft Update "http://support.microsoft.com/kb/968930".
#
# You may change the "." to a computer name, (example: "ComputerName") to get remote system information

$strComputer = "."

$objWin32Bios = Get-WmiObject -Class Win32_BIOS -namespace "root\CIMV2" -computername $strComputer
foreach ($objBiosItem in $objWin32Bios)
{
  Write-Host "BIOSVersion:" $objBiosItem.BIOSVersion
  Write-Host "BuildNumber:" $objBiosItem.BuildNumber
  Write-Host "Caption:" $objBiosItem.Caption
  Write-Host "CurrentLanguage:" $objBiosItem.CurrentLanguage
  Write-Host "Description:" $objBiosItem.Description
  Write-Host "InstallableLanguages:" $objBiosItem.InstallableLanguages
  Write-Host "InstallDate:" $objBiosItem.InstallDate
  Write-Host "ListOfLanguages:" $objBiosItem.ListOfLanguages
  Write-Host "Manufacturer:" $objBiosItem.Manufacturer
  Write-Host "Name:" $objBiosItem.Name
  Write-Host "PrimaryBIOS:" $objBiosItem.PrimaryBIOS
  Write-Host "ReleaseDate:" $objBiosItem.ReleaseDate
  Write-Host "SerialNumber2:" $objBiosItem.SerialNumber
  Write-Host "SMBIOSBIOSVersion:" $objBiosItem.SMBIOSBIOSVersion
  Write-Host "SMBIOSMajorVersion:" $objBiosItem.SMBIOSMajorVersion
  Write-Host "SMBIOSMinorVersion:" $objBiosItem.SMBIOSMinorVersion
  Write-Host "SMBIOSPresent:" $objBiosItem.SMBIOSPresent
  Write-Host "SoftwareElementID:" $objBiosItem.SoftwareElementID
  Write-Host "SoftwareElementState:" $objBiosItem.SoftwareElementState
  Write-Host "Status:" $objBiosItem.Status
  Write-Host "TargetOperatingSystem:" $objBiosItem.TargetOperatingSystem
  Write-Host "Version:" $objBiosItem.Version

}