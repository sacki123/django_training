Option Explicit

Dim sFSO
Dim oDrive
Dim oFisrt

oFisrt = 0
Set sFSO = CreateObject("Scripting.FileSystemObject")

WScript.StdOut.WriteLine "{"
For Each oDrive In sFSO.Drives
	Select Case oDrive.DriveType
		Case 2
			If oFisrt = 1 Then
				WScript.StdOut.WriteLine ","
			End If
		    WScript.StdOut.Write """"
		    WScript.StdOut.Write oDrive.DriveLetter
		    WScript.StdOut.Write """: {"
		    WScript.StdOut.Write """Use%"": """
			WScript.StdOut.Write FormatPercent((oDrive.TotalSize - oDrive.FreeSpace) / oDrive.TotalSize, 2, -1)
		    WScript.StdOut.Write ""","
		    WScript.StdOut.Write """Used"": """
		    WScript.StdOut.Write Round((oDrive.TotalSize - oDrive.FreeSpace) /1024 /1024 /1024 , 2) & "G"
		    WScript.StdOut.Write ""","
		    WScript.StdOut.Write """Avail"": """
		    WScript.StdOut.Write Round(oDrive.AvailableSpace /1024 /1024 /1024 , 2) & "G"
		    WScript.StdOut.Write ""","
		    WScript.StdOut.Write """Filesystem"": """
		    WScript.StdOut.Write oDrive.FileSystem
		    WScript.StdOut.Write ""","
		    WScript.StdOut.Write """Mounted"": """
		    WScript.StdOut.Write oDrive.Path
		    WScript.StdOut.Write ""","
		    WScript.StdOut.Write """Size"": """
		    WScript.StdOut.Write Round(oDrive.TotalSize /1024 /1024 /1024 , 2) & "G"
		    WScript.StdOut.Write """"

		    WScript.StdOut.Write "}"

			oFisrt = 1
	End Select
Next
WScript.StdOut.WriteLine ""
WScript.StdOut.WriteLine "}"

Set oDrive = Nothing
Set sFSO = Nothing
