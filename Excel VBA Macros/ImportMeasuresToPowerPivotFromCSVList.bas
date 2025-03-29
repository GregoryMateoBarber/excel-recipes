Function GetModelFormat(mdl As Model, formatName As String) As Object ' TODO add ability to specific format strings
    Select Case UCase(Trim(formatName))
        Case "CURRENCY"
            Set GetModelFormat = mdl.ModelFormatCurrency
        Case "PERCENTAGE", "PERCENT"
            Set GetModelFormat = mdl.ModelFormatPercentage
        Case "WHOLE NUMBER", "INTEGER", "WHOLE"
            Set GetModelFormat = mdl.ModelFormatWholeNumber
        Case "DECIMAL", "NUMBER"
            Set GetModelFormat = mdl.ModelFormatDecimalNumber
        Case Else
            Set GetModelFormat = mdl.ModelFormatGeneral
    End Select
End Function
Sub ImportMeasuresToPowerPivotFromCSVList()
    Dim filePath As String
    filePath = Application.GetOpenFilename("CSV Files (*.csv), *.csv", , "Select a CSV File")

    Dim fileNum As Integer
    fileNum = FreeFile
    Dim lineText As String
    Dim parts() As String

    ListModelTables.Show
	Dim selectedTable As String
	selectedTable = ListModelTables.ComboBox1.Value

	If selectedTable = "" Then
		MsgBox "Operation cancelled or no table selected.", vbExclamation
		Exit Sub
	End If

	Dim mdl As Model
	Set mdl = ThisWorkbook.Model

	Dim mdlTable As ModelTable
	Set mdlTable = ThisWorkbook.Model.ModelTables(selectedTable)

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
				
				Dim mdlFormat As Object
                Set mdlFormat = GetModelFormat(mdl, formatString)

                ThisWorkbook.Model.ModelMeasures.Add measureName, mdlTable, daxFormula, mdlFormat
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
