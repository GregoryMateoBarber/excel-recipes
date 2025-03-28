Sub AddMeasuresFromCSV_WithModelTable()
    Dim filePath As String
    filePath = "C:\Your\File\Path\measures.csv" ' TODO: Change to your filepath.

    Dim fileNum As Integer
    fileNum = FreeFile
    Dim lineText As String
    Dim parts() As String

    Dim mdlTable As ModelTable
    Set mdlTable = ThisWorkbook.Model.ModelTables("YourTableName") ' TODO: Change to your table name.

    Open filePath For Input As #fileNum

    Line Input #fileNum, lineText 

    Do Until EOF(fileNum)
        Line Input #fileNum, lineText
        lineText = Trim(lineText)

        If lineText <> "" Then
            parts = Split(lineText, ",")
            If UBound(parts) >= 2 Then
                Dim measureName As String, daxFormula As String, formatString As String
                
                measureName = Trim(CStr(parts(0)))
                daxFormula = Trim(CStr(parts(1)))
                formatString = Trim(CStr(parts(2)))

                measureName = Replace(measureName, Chr(34), "")
                daxFormula = Replace(daxFormula, Chr(34), "")
                formatString = Replace(formatString, Chr(34), "")

                On Error Resume Next
                ThisWorkbook.Model.ModelMeasures.Add measureName, mdlTable, daxFormula, formatString
                If Err.Number <> 0 Then
                    Debug.Print "Error adding measure: " & measureName & " - " & Err.Description
                    Err.Clear
                Else
                    Debug.Print "Added measure: " & measureName
                End If
                On Error GoTo 0
            Else
                Debug.Print "Skipped malformed line: " & lineText
            End If
        End If
    Loop

    Close #fileNum
    MsgBox "Measures imported successfully.", vbInformation
End Sub