## Return all values from a column in a PowerPivot Data Model Table
### by Jos Woolley

'''
=LET(
	comment, "Takes a Data Model column and returns an array",
	column_to_show, CUBESET("ThisWorkbookDataModel","[Your Table].[Your Column Name].Children"),
	CUBERANKEDMEMBER("ThisWorkbookDataModel",column_to_show,SEQUENCE(CUBESETCOUNT(column_to_show)))
	)
'''