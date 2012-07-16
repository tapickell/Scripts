'*************************************************
' File:		List missing drivers.vbs
' Author:	Andrew D Barnes
' version: 	1.1 Date: 16 March 2010 By : Andrew D Barnes
'
' List devices in device manager with an exclaimation mark
' then output results to a text file in the current folder.
'
' Useful for finding missing drivers after a reimage
' The Device ID's returned can be put in a search engine to locate the driver
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
Set objLogFile = objFSO.CreateTextFile(".\" & strComputer & " missing drivers.txt", ForWriting, True)

	Message = "Computer Details:" & vbCrLf & vbCrLf
On Error Resume Next
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
For Each objItem In colItems
	Message = Message & "Manufacturer: " & objItem.Manufacturer & vbCrLf
	Message = Message & "Model: " & objItem.Model & vbCrLf & vbCrLf
Next

	Message = Message & "Hardware that's not working list" & vbCrLf & vbCrLf
Set colItems = objWMIService.ExecQuery("Select * FROM Win32_ComputerSystemProduct",,48) 
For Each objItem In colItems 
 Message = Message & "Service Tag: " & objItem.IdentifyingNumber & vbCrLf & vbCrLf
Next

Set colItems = objWMIService.ExecQuery _
    ("Select * from Win32_PnPEntity " _
        & "WHERE ConfigManagerErrorCode <> 0")
For Each objItem in colItems
	Message = Message & "Description: " & objItem.Description & vbCrLf
	Message = Message & "Device ID: " & objItem.DeviceID & vbCrLf
Next

objLogFile.Write Message
objLogFile.WriteLine
objLogFile.Close

' Initialize title text.
Title = "Computer Details - " & strComputer & "                  By Andrew D Barnes"

objShell.Popup  Message,, Title, vbInformation + vbOKOnly