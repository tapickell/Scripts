'  ===============================================================
'  /    Author: Marcus L. Farmer
'  /    Script: basicComputerInfo.vbs
'  /      Date: 2-26-2007
'  /   Purpose: quick cursory glance of a computer; useful for troubleshooting
'  /     Usage: double click to run
'  /     Reqs.: administrator privileges on the local computer
'  /    Output: writes output to an HTML file for reporting purposes
'  /  Comments: none
'  ===============================================================

Dim oIE, wshell, strFilename, strComputer 
Dim myMonth, myDay, myYear 
Dim oFS, oHTML, oFolder
Dim oFolders, oSubfolders 
Dim objReg

Const MBSize = 1048052
Const GBSize = 1048052000
Const URL_KEY_PATH = "Software\Microsoft\Internet Explorer\TypedURLs"
Const STARTUP_KEY_PATH = "Software\Microsoft\Windows\CurrentVersion\Run"
Const HKEY_CLASSES_ROOT	= &H80000000
Const HKEY_CURRENT_USER = &H80000001
Const HKEY_LOCAL_MACHINE = &H80000002
Const HKEY_USERS = &H80000003
Const HKEY_CURRENT_CONFIG = &H80000005

Set wsNetwork = CreateObject("WScript.Network") 
strComputer = wsNetwork.ComputerName 
Set wsShell = CreateObject("WScript.Shell")

Set objReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")


myMonth = Right("0" & Month(Date()),2)
myDay = Right("0" & Day(Date()),2)
myYear = Year(Date())

strFilename = "C:\" & myYear & myMonth & myDay & "_" & strComputer & ".htm"
Set oFS = CreateObject("Scripting.FileSystemObject")
Set oHTML = oFS.CreateTextFile(strFilename)

oHTML.Writeline "<html><head><title>Computer report for " & strComputer & "</title></head><body bgcolor=#FFFFCC>"
oHTML.WriteLine "<H2>" & strComputer & "</h2><br>" & "Report created: " & Now()

getPCInfo
getStartupItems
getProgramFiles
getVisitedURLs

Sub getStartupItems()
	oHTML.WriteLine "<h4>Startup Items from Registry</h4>"
	objReg.EnumValues HKEY_LOCAL_MACHINE, STARTUP_KEY_PATH, arrStrings
	For Each subString In arrStrings
		i = i + 1
		fullRegPathAndKey = "HKLM\" & STARTUP_KEY_PATH & "\" & subString
		subStringValue = wsShell.regread(fullRegPathAndKey)
		oHTML.WriteLine "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & i & " - <b>" & _
                    subString & "</b>     " & subStringValue & "<br>"
	Next
End Sub

Sub getProgramFiles()
	oHTML.Writeline "<h4>Program File Folders</h4>"
	Set oFolder = oFS.GetFolder("C:\Program Files")
	Set oSubfolders = oFolder.SubFolders
	For Each folder In oSubfolders
		oHTML.Writeline "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fontsize=2 face='garamond'>" & folder.name & " - " & _
                    FormatNumber(folder.size/MBSize,2) & " MB</font><br>"
	Next
End Sub

Sub getVisitedURLs()
	oHTML.WriteLine "<h4>Visited/Typed URLs</h4>"
	objReg.EnumValues HKEY_CURRENT_USER, URL_KEY_PATH, arrStrings
	For Each subString In arrStrings
		i = i + 1
		fullRegPathAndKey = "HKCU\" & URL_KEY_PATH & "\" & subString
		subStringValue = wsShell.regread(fullRegPathAndKey)
		oHTML.WriteLine "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='" & subStringValue & "' target=_new>" _
                    & subStringValue & "</a><br>"
	Next
End Sub

Sub getPCInfo()
	oHTML.WriteLine "<h4>PC Information</h4>"
	On Error Resume Next
Dim strComputer
Dim objWMIService
Dim propValue
Dim SWBemlocator
Dim UserName
Dim Password
Dim colItems

strComputer = "."
UserName = ""
Passord = ""
Set SWBemlocator = CreateObject("WbemScripting.SWbemLocator")
Set objWMIService = SWBemlocator.ConnectServer(strComputer,"\root\CIMV2",UserName,Password)
Set colItems = objWMIService.ExecQuery("Select * from Win32_ComputerSystem",,48)
For Each objItem In colItems
	oHTML.WriteLine "<b>Domain: </b>" & objItem.Domain & "<br>"
	oHTML.WriteLine "<b>Manufacturer/Model: </b>" & objItem.Manufacturer & " - " & objItem.Model & "<br>"
	oHTML.WriteLine "<b>NumberOfProcessors: </b>" & objItem.NumberOfProcessors & "<br>"
	oHTML.WriteLine "<b>PartOfDomain: </b>" & objItem.PartOfDomain & "<br>"
	oHTML.WriteLine "<b>Status: </b>" & objItem.Status & "<br>"
	For Each propValue In objItem.SystemStartupOptions
		oHTML.WriteLine "<b>SystemStartupOptions: </b>" & propValue & "<br>"
	Next
	oHTML.WriteLine "<b>SystemStartupSetting: </b>" & objItem.SystemStartupSetting & "<br>"
	oHTML.WriteLine "<b>SystemType: </b>" & objItem.SystemType & "<br>"
	oHTML.WriteLine "<b>ThermalState: </b>" & objItem.ThermalState & "<br>"
	oHTML.WriteLine "<b>RAM: </b>" & FormatNumber(objItem.TotalPhysicalMemory/MBSize,2) & " MB<br>"
	oHTML.WriteLine "<b>UserName: </b>" & objItem.UserName & "<br>"
Next

End Sub

Set oIE = CreateObject("InternetExplorer.Application")
With oIE
	.AddressBar = False
	.Height = 600
	.MenuBar = True
	.Resizable = True
	.StatusBar = False
	.ToolBar = False
	.Width = 800
End With
oIE.visible = True
oIE.Navigate("file://" & strFilename)