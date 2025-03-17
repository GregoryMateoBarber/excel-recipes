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
