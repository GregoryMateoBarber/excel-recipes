## Add leading 0s to a string

```
LeadingZeros = Table.TransformColumns(Source, {{"Your Column Name Here", each Text.PadStart(_, 10, "0"), type text}})
```

## Split a string into its numerical and text parts
For splitting strings like "0.67ml" into two columns with "0.67" and "ml"

```
NumberPart = Table.AddColumn(Source, "Number Part", Text.Select([Your Column Name], {"0".."9",".","-"}))
TextPart = Table.AddColumn(Source, "Text Part", Text.Select([Your Column Name], {"A".."Z","a".."z"}))
```

## Fill down empty row information
This is helpful for imports from stylized tables with merged headers.

```
AddIndex = Table.AddIndexColumn(Source, "Index", 1, 1, Int64.Type),
FillDown = Table.FillDown(AddIndex, {"ColumnToFill"}),
RemoveIndex = Table.RemoveColumns(FillDown, {"Index"})
```

## Conditionally replace information in one column based on another Column
This can be helpful when working with stylized tables that only repeat a heading once.

```
ReplacedNull = Table.ReplaceValue(Source,null,each if [Column1] <> null then "Value when not null" else "Value when null",Replacer.ReplaceValue,{"Column2"})
```

## Convert YYYYMM string to date

```
ConvertYYYYMM = Date.FromText(Text.Range([Input Date as String], 0, 4) & "-" & Text.Range([Input Date as String], 4, 2))
```