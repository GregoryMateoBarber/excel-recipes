Sub DisableFieldList()
	Dim pt As PivotTable
	For Each pt In ActiveSheet.PivotTables
		pt.EnableFieldList = False
	Next pt
End Sub

Sub EnableFieldList()
	Dim pt As PivotTable
	For Each pt in ActiveSheet.PivotTables
		pt.EnableFieldList = True
	Next pt
End Sub