Private Sub UserForm_Initialize()
    Dim mdlTable As ModelTable
    ComboBox1.Clear
    ' Populate ComboBox with table names
    For Each mdlTable In ThisWorkbook.Model.ModelTables
        ComboBox1.AddItem mdlTable.Name
    Next mdlTable
    
    If ComboBox1.ListCount > 0 Then ComboBox1.ListIndex = 0 ' select first by default
End Sub

Private Sub btnOK_Click()
    Me.Hide
End Sub

Private Sub btnCancel_Click()
    ComboBox1.Value = ""
    Me.Hide
End Sub