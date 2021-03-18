START TRANSACTION;
DO
    $$ BEGIN
		-- Fill the Member table
        CALL AddMember('Brad', 'Barnes', 'bb@gmail.com', '132-456-7890', 'Avenue B', 'Bellingham', 'AZ', '01234', 'T', 'F');
        CALL AddMember('Cynthia', 'Cats', 'cc@gmail.com', '321-456-7890', 'Avenue C', 'Carrington', 'CO', '45613', 'T', 'T', 'Real Estate Agent', 'fb.com/sfbsrfb', 'ln.com/adevadv');
        CALL AddMember('David', 'Davies', 'dd@gmail.com', '132-888-7890', 'Avenue D', 'Dylanshire', 'DE', '98765', 'F', 'T', 'Real Estate Agent', 'fb.com/fxhgm', 'ln.com/cxgjhm');
        CALL AddMember('Eric', 'Eisenhower', 'ee@gmail.com', '132-456-9999', 'Avenue E', 'Evans', 'AZ', '01234', 'T', 'T');
        CALL AddMember('Frank', 'Fredrick', 'ff@gmail.com', '888-456-7890', 'Avenue F', 'Falls', 'FL', '44455', 'T', 'F');
        CALL AddMember('Greg', 'George', 'gg@gmail.com', '111-222-3333', 'Avenue G', 'Bellingham', 'GA', '78945', 'T', 'F');
        CALL AddMember('Holly', 'Hats', 'hh@gmail.com', '777-777-7777', 'Avenue H', 'Heather', 'HI', '88888', 'F', 'T', 'Real Estate Broker', 'fb.com/xfhmgm', 'ln.com/fghmfghm');
        CALL AddMember('Iggy', 'Igloo', 'ii@gmail.com', '999-999-9999', 'Avenue I', 'Ires', 'IL', '00123', 'T', 'F');
        CALL AddMember('Jessica', 'James', 'jj@gmail.com', '888-888-8888', 'Avenue J', 'Jefferson', 'AZ', '99999', 'T', 'T', 'Real Estate Agent', 'fb.com/ghxghm', 'ln.com/xgfcnfm');

        -- fill Transaction table
        CALL BuySomething(1, 'PayPal', 'CONF-147527582', CAST('JAN-01-2020' AS DATE), 3, 1, 3);
        CALL BuySomething(2, 'PayPal', 'CONF-7527582', CAST('FEB-15-2020' AS DATE), 2, 3, 1);
        CALL BuySomething(3, 'PayPal', 'CONF-7275823', CAST('MAR-15-2020' AS DATE), 0.5, 5, 1);
        CALL BuySomething(4, 'PayPal', 'CONF-758221', CAST('APR-15-2020' AS DATE), 0.5, 5, 1);
        CALL BuySomething(5, 'PayPal', 'CONF-75254', CAST('MAY-15-2020' AS DATE), 10.5, 6, 1);
        CALL BuySomething(6, 'Venmo',  'C.555', CAST('JUN-15-2020' AS DATE), 2.5, 4, 1);
        CALL BuySomething(7, 'Venmo',  'C.111', CAST('JUL-15-2020' AS DATE), 1.5, 7, 1);
        CALL BuySomething(8, 'Venmo',  'C.222', CAST('AUG-15-2020' AS DATE), 0.5, 5, 1);
        CALL BuySomething(9, 'Venmo',  'C.333', CAST('SEP-15-2020' AS DATE), 1.5, 4, 1);
        CALL BuySomething(10, 'Venmo',  'C.444', CAST('NOV-15-2020' AS DATE), 0.5, 8, 1);

        -- fill Lease table
        CALL BuySomething(1, 'PayPal', 'CONF-7532', CAST('JAN-01-2020' AS DATE), 2.5, 11, 3);
        CALL BuySomething(2, 'PayPal', 'CONF-525425', CAST('FEB-15-2020' AS DATE), 3.5, 12, 1);
        CALL BuySomething(3, 'PayPal', 'CONF-456342', CAST('MAR-10-2020' AS DATE), 4.5, 15, 1);
        CALL BuySomething(4, 'PayPal', 'CONF-453452', CAST('APR-12-2020' AS DATE), 1.5, 14, 1);
        CALL BuySomething(5, 'PayPal', 'CONF-7521245', CAST('MAY-21-2020' AS DATE), 4.5, 17, 1);
        CALL BuySomething(6, 'Venmo',  'C.666', CAST('JUN-10-2020' AS DATE), 2.5, 18, 1);
        CALL BuySomething(7, 'Venmo',  'C.777', CAST('JUL-20-2020' AS DATE), 2.5, 17, 1);
        CALL BuySomething(8, 'Venmo',  'C.888', CAST('AUG-15-2020' AS DATE), 4.5, 18, 1);
        CALL BuySomething(9, 'Venmo',  'C.999', CAST('SEP-11-2020' AS DATE), 1.5, 19, 1);
        CALL BuySomething(10, 'Venmo',  'C.452', CAST('DEC-15-2020' AS DATE), 2.5, 19, 1);

        -- fill Session table
        CALL BuySomething(1, 'Venmo', 'C.254', CAST('FEB-05-2020' AS DATE), 2.5, 21, 2, CAST('MAR-10-2021' AS DATE));
        CALL BuySomething(2, 'PayPal', 'CONF-5555525', CAST('FEB-10-2020' AS DATE), 1.5, 27, 3, CAST('OCT-20-2021' AS DATE));
        CALL BuySomething(3, 'PayPal', 'CONF-252452', CAST('MAR-20-2020' AS DATE), 2.5, 22, 3, CAST('OCT-10-2021' AS DATE));
        CALL BuySomething(4, 'PayPal', 'CONF-75257245', CAST('APR-21-2020' AS DATE), 1.5, 23, 3, CAST('OCT-20-2021' AS DATE));
        CALL BuySomething(5, 'Venmo', 'C.369', CAST('MAY-12-2020' AS DATE), 0.5, 23, 3, CAST('MAR-20-2021' AS DATE));
        CALL BuySomething(6, 'PayPal', 'CONF-7527525', CAST('OCT-22-2020' AS DATE), 5.5, 25, 3, CAST('APR-10-2021' AS DATE));
        CALL BuySomething(7, 'PayPal', 'CONF-7583963', CAST('JUL-02-2020' AS DATE), 2.5, 29, 3, CAST('JUL-20-2021' AS DATE));
        CALL BuySomething(8, 'PayPal', 'CONF-6974374', CAST('AUG-01-2020' AS DATE), 1.5, 27, 3, CAST('APR-10-2021' AS DATE));
        CALL BuySomething(9, 'PayPal', 'CONF-9673258', CAST('OCT-10-2020' AS DATE), 0.5, 27, 3, CAST('JUL-20-2021' AS DATE));
        CALL BuySomething(10, 'Venmo', 'C.589', CAST('SEP-20-2020' AS DATE), 0.5, 27, 3, CAST('MAY-10-2021' AS DATE));

        -- fill Lesson table
        CALL BuySomething(1, 'Venmo', 'C.885', CAST('FEB-22-2020' AS DATE), 2.5, 55, 2, CAST('FEB-20-2021' AS DATE));
        CALL BuySomething(2, 'Venmo', 'C.884', CAST('FEB-21-2020' AS DATE), 2, 32, 2, CAST('FEB-22-2021' AS DATE));
        CALL BuySomething(3, 'Venmo', 'C.883', CAST('MAR-12-2020' AS DATE), 3, 33, 2, CAST('FEB-11-2021' AS DATE));
        CALL BuySomething(4, 'Venmo', 'C.882', CAST('OCT-22-2020' AS DATE), 4, 55, 1, CAST('JUL-12-2021' AS DATE));
        CALL BuySomething(5, 'PayPal', 'CONF-687358', CAST('FEB-12-2021' AS DATE), 0.3, 61, 3, CAST('JUL-20-2021' AS DATE));
        CALL BuySomething(5, 'PayPal', 'CONF-6387582', CAST('JUL-11-2021' AS DATE), 0.2, 62, 3, CAST('JUL-12-2021' AS DATE));
        CALL BuySomething(5, 'PayPal', 'CONF-783572', CAST('AUG-10-2021' AS DATE), 0.1, 63, 3, CAST('SEP-20-2021' AS DATE));
        CALL BuySomething(5, 'PayPal', 'CONF-758275823', CAST('FEB-01-2021' AS DATE), 0.2, 64, 3, CAST('SEP-21-2021' AS DATE));
        CALL BuySomething(9, 'PayPal', 'CONF-8527852', CAST('SEP-10-2021' AS DATE), 0.5, 68, 3, CAST('OCT-25-2021' AS DATE));
        CALL BuySomething(10, 'PayPal', 'CONF-89637582', CAST('NOV-10-2021' AS DATE), 4.5, 68, 3, CAST('NOV-20-2021' AS DATE));
		
		-- Fill the Purchase Amount History
		UPDATE Purchase SET Amount = 1 WHERE PurchaseConf = 'CONF-147527582';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('JUL-10-2020' AS DATE) 
		WHERE PurchaseID = (SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-147527582');
		
		UPDATE Purchase SET Amount = 2.1 WHERE PurchaseConf = 'CONF-7527582';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('JUL-20-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-7527582');
		
		UPDATE Purchase SET Amount = 3 WHERE PurchaseConf = 'CONF-7275823';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('AUG-10-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-7275823');
		
		UPDATE Purchase SET Amount = 4 WHERE PurchaseConf = 'CONF-758221';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('AUG-20-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-758221');
		
		UPDATE Purchase SET Amount = 5 WHERE PurchaseConf = 'CONF-75254';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('SEP-20-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-75254');
		
		UPDATE Purchase SET Amount = 6 WHERE PurchaseConf = 'CONF-7532';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('SEP-10-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-7532');
		
		UPDATE Purchase SET Amount = 7 WHERE PurchaseConf = 'CONF-525425';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('NOV-20-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-525425');
		
		UPDATE Purchase SET Amount = 8 WHERE PurchaseConf = 'CONF-456342';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('NOV-10-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-456342');
		
		UPDATE Purchase SET Amount = 9 WHERE PurchaseConf = 'CONF-453452';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('DEC-20-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-453452');
		
		UPDATE Purchase SET Amount = 10 WHERE PurchaseConf = 'CONF-7521245';
		UPDATE PurchaseAmountHistory SET ChangeDate = CAST('DEC-10-2020' AS DATE) 
		WHERE PurchaseID =(SELECT PurchaseID FROM Purchase WHERE PurchaseConf = 'CONF-7521245');
		
		-- Edit a few of the days when things were rented
		UPDATE Lease SET StartDate = CAST('JAN-10-2021' AS DATE) WHERE Lease.OfferingID = 12;
		UPDATE Lease SET StartDate = CAST('FEB-02-2021' AS DATE) WHERE Lease.OfferingID = 14;
		
    END $$;
COMMIT TRANSACTION;