CREATE OR REPLACE PROCEDURE BuySomething(
    p_MemberID IN DECIMAL,
    p_Platform IN VARCHAR,
    p_PurchaseConf IN VARCHAR,
    p_PurchaseDate IN DATE,
    p_Amount IN DECIMAL,
	p_OfferingID IN DECIMAL,
	p_ShipSpeedID IN DECIMAL,
    p_DateChosen IN DATE DEFAULT NULL
) LANGUAGE plpgsql AS $proc2$

DECLARE
    v_OfferingType VARCHAR(7);
BEGIN
    INSERT INTO Purchase(PurchaseID, Platform, PurchaseConf, PurchaseDate, Amount)
    VALUES(nextval('purchase_seq'), p_Platform, p_PurchaseConf, p_PurchaseDate, p_Amount);

    -- Find the OfferingType
    SELECT OfferingType
    INTO v_OfferingType
    FROM Offering
    WHERE p_OfferingID = Offering.OfferingID;

	-- Put the purchase in the correct junction table based on the offering type
    IF v_OfferingType = 'PRODUCT' THEN
        INSERT INTO Transaction(TransactionID, MemberID, OfferingID, ShipSpeedID, PurchaseID)
        VALUES(nextval('transaction_seq'), p_MemberID, p_OfferingID, p_ShipSpeedID, currval('purchase_seq'));

    ELSEIF v_OfferingType = 'RENTAL' THEN
		-- Rentals will only pay for shipping immediately, 
		-- and be charged again if they do not return the item in time
        INSERT INTO Lease(LeaseID, MemberID, OfferingID, ShipSpeedID, PurchaseID, StartDate)
        VALUES(nextval('lease_seq'), p_MemberID, p_OfferingID, p_ShipSpeedID, currval('purchase_seq'), CURRENT_DATE);

    ELSEIF  v_OfferingType = 'SERVICE' THEN
        INSERT INTO Session(SessionID, MemberID, OfferingID, PurchaseID, SessionDateTime)
        VALUES(nextval('session_seq'), p_MemberID, p_OfferingID, currval('purchase_seq'), p_DateChosen);

    ELSEIF  v_OfferingType = 'CLASS' THEN
        INSERT INTO Lesson(LessonID, MemberID, OfferingID, PurchaseID, LessonDateTime)
        VALUES(nextval('lesson_seq'), p_MemberID, p_OfferingID, currval('purchase_seq'), p_DateChosen);

    END IF;

END;
$proc2$;

START TRANSACTION;
DO
    $$ BEGIN
        CALL BuySomething(1, 'PayPal', 'CONF-0001234', CURRENT_DATE, 10.5, 2, 3);
    END $$;
COMMIT TRANSACTION;