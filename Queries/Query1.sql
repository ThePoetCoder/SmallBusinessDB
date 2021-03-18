SELECT 
	Member.FirstName, 
	Member.LastName, 
	Offering.Name AS "Bought",
 	PaidFor.PurchaseDate AS "Date of Purchase", 
	PurchaseAmountHistory.ChangeDate AS "Date of Change", 
	PurchaseAmountHistory.NewAmount - PurchaseAmountHistory.OldAmount AS "Change in Earnings",
	CASE
		WHEN PurchaseAmountHistory.NewAmount - PurchaseAmountHistory.OldAmount < 0 THEN 'Refund'
		WHEN PurchaseAmountHistory.NewAmount - PurchaseAmountHistory.OldAmount > 0 THEN 'Tip'
	END AS "Type"
FROM PaidFor
LEFT JOIN PurchaseAmountHistory ON PaidFor.PurchaseID = PurchaseAmountHistory.PurchaseID
JOIN Member ON Member.MemberID = PaidFor.MemberID
JOIN Offering ON Offering.OfferingID = PaidFor.OfferingID
WHERE PurchaseAmountHistory.AmountChangeID IS NOT NULL
ORDER BY "Date of Purchase";
