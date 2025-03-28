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

