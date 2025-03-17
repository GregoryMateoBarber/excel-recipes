## Return all values from a column in a PowerPivot Data Model Table
### by Jos Woolley

```
=LET(
	comment, "Takes a Data Model column and returns an array",
	column_to_show, CUBESET("ThisWorkbookDataModel","[Your Table].[Your Column Name].Children"),
	CUBERANKEDMEMBER("ThisWorkbookDataModel",column_to_show,SEQUENCE(CUBESETCOUNT(column_to_show)))
	)
```

## Calculate Quarter from Date

```
=LET(
	comment, "Turns a date value into a quarter value, i.e., 1, 2, 3, or 4",
	ROUNDUP(MONTH([Date])/3,0)
	)
```

## Cartesian Product of two ranges
Repeat all items in one array for each item of another array.
This can be combined with a TEXTSPLIT() function to split it into two columns.

```
=LET(
	comment, "Repeat all items in array_a for all items in array_b",
	array_a, [Range1],
	array_b, [Range2],
	array_a_count, ROWS(array_a),
	array_b_count, ROWS(array_b),
	totals, array_a_count * array_b_count,
	seq, SEQUENCE(totals,1),
	array_a_index, INT((seq-1)/array_b_count)+1,
	array_b_index, MOD(seq-1, array_b_count)+1,
	INDEX(array_a,array_a_index)&"|"&INDEX(array_b,array_b_index)
	)
```
