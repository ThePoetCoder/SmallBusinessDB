SELECT
	Count(ProductOffering.OfferingID) AS "Number of Products",
	Count(RentalOffering.OfferingID) AS "Number of Rentals",
	Count(ServiceOffering.OfferingID) AS "Number of Services",
	Count(ClassOffering.OfferingID) AS "Number of Classes"
FROM Offering
LEFT JOIN ProductOffering ON Offering.OfferingID = ProductOffering.OfferingID
LEFT JOIN RentalOffering ON Offering.OfferingID = RentalOffering.OfferingID
LEFT JOIN ServiceOffering ON Offering.OfferingID = ServiceOffering.OfferingID
LEFT JOIN ClassOffering ON Offering.OfferingID = ClassOffering.OfferingID;