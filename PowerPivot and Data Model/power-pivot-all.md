## Aggregate data and count number of rows which meet a criteria
This can be used in situations where you need to group rows by some criteria and see the number of rows which meet a minimum level.
For example, this will allow you to see the number of rows which, when grouped by AccountID and BrandID, have purchased above a minimum amount.
Mostly aimed at those working with sales data.

```
Accounts_Which_Met_Sales_Threshold_By_Brand :=
CALCULATE(
	COUNTROWS(
		FILTER(
			SUMMARIZE(
				SalesData,
				SalesData[AccountID],
				SalesData[BrandID],
				"AggregateSales", SUM(SalesData[SalesVolume])
			),
			[AggregateSales] > Threshold
		)
	)
)
```