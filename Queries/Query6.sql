SELECT
	PurchaseDate,
	SUM(Amount)
		OVER 
	(ORDER BY PurchaseDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
	AS RunningTotal,
	Amount
FROM PaidFor;
