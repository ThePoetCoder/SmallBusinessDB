SELECT
	PaidFor.MemberID,
	Member.FirstName || ' ' || Member.LastName AS "Name",
	SUM(PaidFor.Amount) As "Amount Spent",
	Count(PaidFor.PurchaseID) As "Number of Purchases"
FROM PaidFor
JOIN Member ON Member.MemberID = PaidFor.MemberID
JOIN ClientMember ON ClientMember.MemberID = PaidFor.MemberID
GROUP BY PaidFor.MemberID, Member.FirstName, Member.LastName, ClientMember.SentGift
HAVING ClientMember.SentGift = 'F'
ORDER BY "Amount Spent" DESC LIMIT 3;
