## Aggregate data and count number of rows which meet a criteria
This can be used in situations where you need to group rows by some criteria and see the number of rows which meet a minimum level.
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