SELECT 
	Offering.Name AS "What Is OverDue?",
	Member.FirstName || ' ' || Member.LastName AS "Who Has It?",
	CAST(
		Lease.StartDate + interval '1' day * RentalOffering.RentalDurationDays AS DATE
		) AS "When was it due?",
	Member.Phone,
	Member.Email
FROM RentalOffering
JOIN Lease ON RentalOffering.OfferingID = Lease.OfferingID
JOIN PaidFor ON PaidFor.OfferingID = Lease.OfferingID
JOIN Offering ON Offering.OfferingID = Lease.OfferingID
JOIN Member ON PaidFor.MemberID = Member.MemberID
WHERE Lease.StartDate + interval '1' day * RentalOffering.RentalDurationDays < CURRENT_DATE;