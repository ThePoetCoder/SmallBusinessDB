SELECT
	OfferingType,
	SUM(Amount)
FROM PaidFor
GROUP BY OfferingType;