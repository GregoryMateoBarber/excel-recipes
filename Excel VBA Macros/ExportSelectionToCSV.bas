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