Option Explicit

Const fsDoOverwrite     = true  ' Overwrite file with base64 code
Const fsAsASCII         = false ' Create base64 code file as ASCII file
Const adTypeBinary      = 1     ' Binary file is encoded

' Variables for writing base64 code to file
Dim objFSO
Dim objFileOut

' Variables for encoding
Dim objXML
Dim objDocElem
Dim objStream

' Open data stream from picture
Set objStream = CreateObject("ADODB.Stream")
objStream.Type = adTypeBinary
objStream.Open()
objStream.LoadFromFile("config.txt")

' Create XML Document object and root node
' that will contain the data
Set objXML = CreateObject("MSXml2.DOMDocument")
Set objDocElem = objXML.createElement("Base64Data")
objDocElem.dataType = "bin.base64"
objDocElem.nodeTypedValue = objStream.Read()

' Open data stream to base64 code file
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFileOut = objFSO.CreateTextFile("encoded.txt", fsDoOverwrite, fsAsASCII)

' Get base64 value and write to file
objFileOut.Write objDocElem.text
objFileOut.Close()

' Clean all
Set objFSO = Nothing
Set objFileOut = Nothing
Set objXML = Nothing
Set objDocElem = Nothing
Set objStream = Nothing