DROP VIEW paidfor;

CREATE OR REPLACE VIEW paidfor AS
SELECT
	Purchase.PurchaseID,
	Purchase.Platform,
	Purchase.PurchaseConf,
	Purchase.PurchaseDate,
	Purchase.Amount,
	Transaction.TransactionID,
	Lease.LeaseID,
	Session.SessionID,
	Lesson.LessonID,
	CASE
		WHEN Transaction.MemberID IS NOT NULL THEN Transaction.MemberID
		WHEN Lease.MemberID IS NOT NULL THEN Lease.MemberID
		WHEN Session.MemberID IS NOT NULL THEN Session.MemberID
		WHEN Lesson.MemberID IS NOT NULL THEN Lesson.MemberID
	END AS "memberid",
	CASE
		WHEN Transaction.OfferingID IS NOT NULL THEN Transaction.OfferingID
		WHEN Lease.OfferingID IS NOT NULL THEN Lease.OfferingID
		WHEN Session.OfferingID IS NOT NULL THEN Session.OfferingID
		WHEN Lesson.OfferingID IS NOT NULL THEN Lesson.OfferingID
	END AS "offeringid",
	CASE
		WHEN Transaction.OfferingID IS NOT NULL THEN 'PRODUCT'
		WHEN Lease.OfferingID IS NOT NULL THEN 'RENTAL'
		WHEN Session.OfferingID IS NOT NULL THEN 'SERVICE'
		WHEN Lesson.OfferingID IS NOT NULL THEN 'CLASS'
	END AS "offeringtype"
FROM Purchase
LEFT JOIN Transaction ON Purchase.PurchaseID = Transaction.PurchaseID
LEFT JOIN Lease ON Purchase.PurchaseID = Lease.PurchaseID
LEFT JOIN Session ON Purchase.PurchaseID = Session.PurchaseID
LEFT JOIN Lesson ON Purchase.PurchaseID = Lesson.PurchaseID;

SELECT *
FROM paidfor;
