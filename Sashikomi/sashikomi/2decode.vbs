Option Explicit

Const foForReading          = 1 ' Open base 64 code file for reading
Const foAsASCII             = 0 ' Open base 64 code file as ASCII file
Const adSaveCreateOverWrite = 2 ' Mode for ADODB.Stream
Const adTypeBinary          = 1 ' Binary file is encoded

' Variables for reading base64 code from file
Dim objFSO
Dim objFileIn
Dim objStreamIn

' Variables for decoding
Dim objXML
Dim objDocElem
Dim objStream

' Open data stream from base64 code filr
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFileIn   = objFSO.GetFile("encoded.txt")
Set objStreamIn = objFileIn.OpenAsTextStream(foForReading, foAsASCII)

' Create XML Document object and root node
' that will contain the data
Set objXML = CreateObject("MSXml2.DOMDocument")
Set objDocElem = objXML.createElement("Base64Data")
objDocElem.DataType = "bin.base64"
' Set text value
objDocElem.text = objStreamIn.ReadAll()

' Open data stream to picture file
Set objStream = CreateObject("ADODB.Stream")
objStream.Type = adTypeBinary
objStream.Open()

' Get binary value and write to file
objStream.Write objDocElem.NodeTypedValue
objStream.SaveToFile "final.txt", adSaveCreateOverWrite

' Clean all
Set objFSO = Nothing
Set objFileIn = Nothing
Set objStreamIn = Nothing
Set objXML = Nothing
Set objDocElem = Nothing
Set objStream = Nothing