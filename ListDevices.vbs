'*************************************************
' File:		List devices.vbs
' Author:	Andrew Barnes
' version: 	1.0 Date: 18 February 2010 By : Andrew D Barnes
' output all devices and hardware IDs
'*************************************************

' Get object
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("Wscript.Shell")
Set objNet = CreateObject("WScript.Network")

' Define Objects
strComputer = objNet.ComputerName
StrDomain = objnet.UserDomain
StrUser = objNet.UserName


' ------ Set Constants ---------
Const ForWriting = 2
Const HKEY_LOCAL_MACHINE = &H80000002
Const SEARCH_KEY = "DigitalProductID"

' ------ Set Variables ---------
Set objLogFile = objFSO.CreateTextFile(".\" & strComputer & " Installed drivers.txt", ForWriting, True)




Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
For Each objItem In colItems
Message = "Computer Details:" & vbCrLf & vbCrLf
 Message = Message & "Manufacturer: " & objItem.Manufacturer & vbCrLf
 Message = Message & "Model: " & objItem.Model & vbCrLf & vbCrLf
Next

Set colItems = objWMIService.ExecQuery("Select * FROM Win32_ComputerSystemProduct",,48) 
For Each objItem In colItems 
 Message = Message & "Service Tag: " & objItem.IdentifyingNumber & vbCrLf & vbCrLf
Next


Message = Message & "Installed Hardware list" & vbCrLf & vbCrLf

On Error Resume Next
Set objWMIService = GetObject(_
    "winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery _
    ("Select * from Win32_PnPEntity ")
For Each objItem in colItems
	Message = Message & "Class GUID: " & objItem.ClassGuid & vbCrLf
	Message = Message & "Description: " & objItem.Description & vbCrLf
	Message = Message & "Device ID: " & objItem.DeviceID & vbCrLf
        Message = Message & "Manufacturer: " & objItem.Manufacturer & vbCrLf
        Message = Message & "Name: " & objItem.Name & vbCrLf
        Message = Message & "PNP Device ID: " & objItem.PNPDeviceID & vbCrLf
        Message = Message & "Service: " & objItem.Service & vbCrLf & vbCrLf
Next

objLogFile.Write Message
objLogFile.WriteLine
objLogFile.Close


' Initialize title text.
Title = "Computer Details - " & strComputer & "                  By Andrew D Barnes"

objShell.Popup  Message,, Title, vbInformation + vbOKOnly