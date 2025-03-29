## Disable/Enable editing of a Pivot Table's field list
Filename: LockFieldList.bas

## Export the current selection to .csv file
Filename: ExportSelectionToCSV.bas

## Bulk import DAX measures from a .csv
Can help when you are creating reports with standard measures and metrics but in different Excel files.

### Important
The .csv file requires a specific formatting style.
Column Headers: MeasureName, DAXFormula, Format
- MeasureName: Name of the measure. Should not be a name which already exists.
- DAXFormula: The DAX formula to add. Cannot have an "=" at the start.
- Format: Text string with one of the following formats. If the name used is not recognized, it will default to General.
  - Currency
  - Percentage // Percent
  - Whole number // Integer // Whole
  - Decimal // Number

### GUI version
Filename: ImportMeasuresToPowerPivotFromCSVList.bas
This will open a window with a dropdown to select the table name, but it requires the addition of a UserForm (ListModelTables.frm).

### Manual version
Filename: ImportMeasuresToPowerPivotFromCSVManual.bas
This will require you to modify the VBA code with your table name, but won't have the added step of adding a UserForm.

