Sub ImportVBAModuleFromBAS()
    Dim vbProj As VBIDE.VBProject
    Dim ModulePath As String
    
    'Set the path to your external VBA file
    ModulePath = "C:\Path\To\Your\MyModule.bas"
    
    ' Reference to the current workbook's VBA Project
    Set vbProj = ThisWorkbook.VBProject
    
    ' Import your VBA module
    vbProj.VBComponents.Import ModulePath
    
    MsgBox "Module imported successfully.", vbInformation
End Sub
