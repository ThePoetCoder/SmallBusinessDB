CREATE OR REPLACE PROCEDURE AddOffering(
    p_OfferingType IN VARCHAR,
    p_Name IN VARCHAR,
    p_Description IN VARCHAR,
    p_PictureLink IN VARCHAR,
    p_Price IN DECIMAL,

    p_Warranty IN VARCHAR DEFAULT NULL,
    p_Supply IN DECIMAL DEFAULT NULL,
    p_RentalDurationDays IN DECIMAL DEFAULT NULL,
    p_NextDateAvailable IN DATE DEFAULT NULL,
    p_NumberOfLessons IN DECIMAL DEFAULT NULL,
    p_ClassType IN VARCHAR DEFAULT NULL,
    p_ClassSize IN DECIMAL DEFAULT NULL,
    p_AdditionalPercent IN DECIMAL DEFAULT NULL,
    p_DiscountPercent IN DECIMAL DEFAULT NULL,
    p_RefCode IN VARCHAR DEFAULT NULL
) LANGUAGE plpgsql AS $proc3$

BEGIN
    INSERT INTO Offering(OfferingID, OfferingType, Name, Description, PictureLink, Price)
    VALUES(nextval('offering_seq'), p_OfferingType, p_Name, p_Description, p_PictureLink, p_Price);

    IF p_OfferingType = 'PRODUCT' THEN
        INSERT INTO ProductOffering(OfferingID, Warranty, Supply)
        VALUES (currval('offering_seq'), p_Warranty, p_Supply);

    ELSEIF p_OfferingType = 'RENTAL' THEN
        INSERT INTO RentalOffering(OfferingID, RentalDurationDays, Supply)
        VALUES (currval('offering_seq'), p_RentalDurationDays, p_Supply);

    ELSEIF  p_OfferingType = 'SERVICE' THEN
        INSERT INTO ServiceOffering(OfferingID, NextDateAvailable)
        VALUES (currval('offering_seq'), p_NextDateAvailable);

    ELSEIF  p_OfferingType = 'CLASS' THEN
        INSERT INTO ClassOffering(OfferingID, NumberOfLessons, ClassType)
        VALUES (currval('offering_seq'), p_NumberOfLessons, p_ClassType);

        IF p_ClassType = 'GROUP' THEN
            INSERT INTO GroupClass(OfferingID, NextDateAvailable, ClassSize)
            VALUES (currval('offering_seq'), p_NextDateAvailable, p_ClassSize);

        ELSEIF p_ClassType = 'PRIVATE' THEN
            INSERT INTO PrivateClass(OfferingID, AdditionalPercent)
            VALUES (currval('offering_seq'), p_AdditionalPercent);

        ELSEIF p_ClassType = 'VIRTUAL' THEN
            INSERT INTO VirtualClass(OfferingID, DiscountPercent)
            VALUES (currval('offering_seq'), p_DiscountPercent);

        ELSEIF p_ClassType = 'GENERIC' THEN
            INSERT INTO GenericClass(OfferingID, DiscountPercent, RefCode)
            VALUES (currval('offering_seq'), p_DiscountPercent, p_RefCode);

        END IF;
    END IF;

END;
$proc3$;

START TRANSACTION;
DO
    $$ BEGIN
        CALL AddOffering(
			p_OfferingType => 'RENTAL', 
			p_Name => 'Rental #11', 
			p_Description => 'Description for rental #11', 
			p_PictureLink => 'drive.google.user/business/rentals/11.png', 
			p_Price => 1.1,
			p_Supply => 11, 
			p_RentalDurationDays => 11);
    END $$;
COMMIT TRANSACTION;
