## Disable editing of a Pivot Table's field list
You will need to use the EnableFieldList macro to reenable editing of the field list.

```
Sub DisableFieldList()
	Dim pt As PivotTable
	For Each pt In ActiveSheet.PivotTables
		pt.EnableFieldList = False
	Next pt
End Sub
```

## Enable editing of a PivotTable FieldList

```
Sub EnableFieldList()
	Dim pt As PivotTable
	For Each pt in ActiveSheet.PivotTables
		pt.EnableFieldList = True
	Next pt
End Sub
```

## Export the current selection to .csv file

```
Option Explicit
Sub ExportAsCSV()
	
	Dim MyFileName As String
	Dim CurrentWB As Workbook, TempWB As Workbook
	Dim CurrentDate As String
	
	Set CurrentWB = ActiveWorkbook
	ActiveWorkbook.ActiveSheet.UsedRange.Copy
	
	Set TempWB = Application.Workbooks.Add(1)
	With TempWB.Sheets(1).Range("A1")
		.PasteSpecial xlPasteValues
		.PasteSpecial xlPasteFormats
	End With
	
	CurrentDate = Format(Date, "yyyy-mm-dd")
	
	'Dim Change below to "- 4" to become compatible with .xls files
	MyFileName = CurrentWB.Path & "\" & CurrentDate & " " & Left(CurrentWB.Name, Len(CurrentWB.Name) - 5) & ".csv"
	
	Application.DisplayAlerts = False
	TempWB.Save As Filename:=MyFileName, FileFormat:=xlcsv, CreateBackup:=False, Local:=True
	TempWB.Close SaveChanges:=False
	Application.DisplayAlerts = True
End Sub
```

## Bulk import DAX measures from a .csv
Can help when you are creating reports with standard measures and metrics but in different Excel files.
### Important
Before using, you must 

1. Have a table created in the Power Pivot data Model.
2. Change the file path in the module to your file path.
3. Change the table name in the module to your table.

```
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

```
