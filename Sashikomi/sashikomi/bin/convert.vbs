Option Explicit
'*******************************************************************************
'CSV TSV_converter.vbs
'  タブ区切りをカンマ区切りに変換
'  INPUT : 変換元ファイル
'  OUTPUT: 変換元ファイル名.csv
'*******************************************************************************

Dim objFSO                        'As Object
Dim objArg                        'As Object
Dim objInput                      'As Object
Dim objOutput                     'As Object
Dim strLine                       'As String
Dim i                             'As int
Dim pathName, fileName, fileExt   'As String
Dim cnvExt, chrBefore, chrAfter   'As String

Set objFSO = Wscript.CreateObject("Scripting.FileSystemObject")
Set objArg = Wscript.Arguments

For i = 0 To objArg.Count - 1
  Set objInput = objFSO.OpenTextFile(objArg(i), 1)                                 'ForReading
  pathName = objFSO.GetFile(objArg(i)).ParentFolder
  fileName = objFSO.GetBaseName(objArg(i))
  fileExt = objFSO.GetExtensionName(objArg(i))

  cnvExt =".csv"
  chrBefore = Chr(9)
  chrAfter = Chr(44)

  Set objOutput = objFSO.OpenTextFile(pathName & "\" & fileName & "_1" & cnvExt, 2, True) 'ForWriting

  Do Until objInput.AtEndOfStream
    strLine = Replace(objInput.ReadLine, chrBefore, chrAfter)
    objOutput.WriteLine (strLine)
  Loop
  objInput.Close
  objOutput.Close
Next 'i

Set objFSO = Nothing
Set objArg = Nothing

Wscript.Quit (0)