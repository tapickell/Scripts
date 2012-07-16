Function funArg()
{
switch ($args)
{
"all" { gwmi win32_logicalDisk }
"c" { (gwmi win32_logicalDisk)[0] }
"free" { (gwmi win32_logicaldisk)[0].freespace }
"help" { $help = @"
This script will print out the drive information for 
All drives, only the c: drive or the free space on the c: drive
It also will print out a help topic
EXAMPLE:
 >GetDriveArgs.ps1 all
     Prints out information on all drives
>GetDriveArgs.ps1 c
     Prints out information on only the c: drive
>GetDriveArgs.ps1 free
     Prints out freespace on the c: drive
"@ ; Write-Host $help }
}
}

#$args = "help"
funArg($args)