-- Drop All Tables
DROP TABLE IF EXISTS Purchase CASCADE;
DROP TABLE IF EXISTS PurchaseAmountHistory CASCADE;
DROP TABLE IF EXISTS Zip CASCADE;
DROP TABLE IF EXISTS City CASCADE;
DROP TABLE IF EXISTS State CASCADE;
DROP TABLE IF EXISTS Member CASCADE;
DROP TABLE IF EXISTS ClientMember CASCADE;
DROP TABLE IF EXISTS PeerMember CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;
DROP TABLE IF EXISTS ShipSpeed CASCADE;
DROP TABLE IF EXISTS Lease CASCADE;
DROP TABLE IF EXISTS Session CASCADE;
DROP TABLE IF EXISTS Lesson CASCADE;
DROP TABLE IF EXISTS Offering CASCADE;
DROP TABLE IF EXISTS ProductOffering CASCADE;
DROP TABLE IF EXISTS RentalOffering CASCADE;
DROP TABLE IF EXISTS ServiceOffering CASCADE;
DROP TABLE IF EXISTS ClassOffering CASCADE;
DROP TABLE IF EXISTS GroupClass CASCADE;
DROP TABLE IF EXISTS PrivateClass CASCADE;
DROP TABLE IF EXISTS VirtualClass CASCADE;
DROP TABLE IF EXISTS GenericClass CASCADE;

-- Drop All Sequences
DROP SEQUENCE IF EXISTS purchase_seq;
DROP SEQUENCE IF EXISTS purchaseamounthistory_seq;
DROP SEQUENCE IF EXISTS zip_seq;
DROP SEQUENCE IF EXISTS city_seq;
DROP SEQUENCE IF EXISTS state_seq;
DROP SEQUENCE IF EXISTS member_seq;
DROP SEQUENCE IF EXISTS transaction_seq;
DROP SEQUENCE IF EXISTS shipspeed_seq;
DROP SEQUENCE IF EXISTS lease_seq;
DROP SEQUENCE IF EXISTS session_seq;
DROP SEQUENCE IF EXISTS lesson_seq;
DROP SEQUENCE IF EXISTS offering_seq;

-- Drop All Foreign Key Indexes
DROP INDEX IF EXISTS member_cityid_idx;
DROP INDEX IF EXISTS member_stateid_idx;
DROP INDEX IF EXISTS member_zipid_idx;
DROP INDEX IF EXISTS clientmember_memberid_idx;
DROP INDEX IF EXISTS peermember_memberid_idx;
DROP INDEX IF EXISTS purchaseamounthistory_purchaseid_idx;
DROP INDEX IF EXISTS transaction_memberid_idx;
DROP INDEX IF EXISTS transaction_offeringid_idx;
DROP INDEX IF EXISTS transaction_shipspeedid_idx;
DROP INDEX IF EXISTS transaction_purchaseid_idx;
DROP INDEX IF EXISTS lease_memberid_idx;
DROP INDEX IF EXISTS lease_offeringid_idx;
DROP INDEX IF EXISTS lease_shipspeedid_idx;
DROP INDEX IF EXISTS lease_purchaseid_idx;
DROP INDEX IF EXISTS session_memberid_idx;
DROP INDEX IF EXISTS session_offeringid_idx;
DROP INDEX IF EXISTS session_purchaseid_idx;
DROP INDEX IF EXISTS lesson_memberid_idx;
DROP INDEX IF EXISTS lesson_offeringid_idx;
DROP INDEX IF EXISTS lesson_purchaseid_idx;
DROP INDEX IF EXISTS productoffering_offeringid_idx;
DROP INDEX IF EXISTS rentaloffering_offeringid_idx;
DROP INDEX IF EXISTS serviceoffering_offeringid_idx;
DROP INDEX IF EXISTS classoffering_offeringid_idx;
DROP INDEX IF EXISTS groupclass_offeringid_idx;
DROP INDEX IF EXISTS privateclass_offeringid_idx;
DROP INDEX IF EXISTS virtualclass_offeringid_idx;
DROP INDEX IF EXISTS genericclass_offeringid_idx;

-- Drop All Query Driven Indexes
DROP INDEX IF EXISTS purchase_purchaseconf_idx;
DROP INDEX IF EXISTS member_firstname_idx;
DROP INDEX IF EXISTS lesson_lessondatetime_idx;

-- Create All Tables
CREATE TABLE Purchase(
	PurchaseID DECIMAL(12) NOT NULL PRIMARY KEY,
	Platform VARCHAR(15) NOT NULL,
	PurchaseConf VARCHAR(30) NOT NULL,
	PurchaseDate DATE NOT NULL,
	Amount DECIMAL(8, 2) NOT NULL
);

CREATE TABLE PurchaseAmountHistory(
	AmountChangeID DECIMAL(12) NOT NULL PRIMARY KEY,
	OldAmount DECIMAL(8, 2) NOT NULL,
	NewAmount DECIMAL(8, 2) NOT NULL,
	PurchaseID DECIMAL(12) NOT NULL,
	FOREIGN KEY(PurchaseID) REFERENCES Purchase(PurchaseID),
	ChangeDate DATE NOT NULL
);

CREATE TABLE ShipSpeed(
    ShipSpeedID DECIMAL(12) NOT NULL PRIMARY KEY,
    ShipSpeedName VARCHAR(10) NOT NULL,
    ShipSpeedPrice DECIMAL(8, 2) NOT NULL,
    ShipSpeedDesc VARCHAR(40) NOT NULL
);

CREATE TABLE Zip(
    ZipID DECIMAL(12) NOT NULL PRIMARY KEY,
    ZipNumber VARCHAR(20) NOT NULL
);

CREATE TABLE City(
    CityID DECIMAL(12) NOT NULL PRIMARY KEY,
    CityName VARCHAR(20) NOT NULL
);

CREATE TABLE State(
    StateID DECIMAL(12) NOT NULL PRIMARY KEY,
    StateAbbrv VARCHAR(2) NOT NULL,
    StateName VARCHAR(20) NOT NULL
);

CREATE TABLE Member(
    MemberID DECIMAL(12) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(24) NOT NULL,
    LastName VARCHAR(24) NOT NULL,
    Email VARCHAR(24) NOT NULL,
    Phone VARCHAR(24),
    Address VARCHAR(40),
    CityID DECIMAL(12) NOT NULL,
    FOREIGN KEY(CityID) REFERENCES City(CityID),
    StateID DECIMAL(12) NOT NULL,
    FOREIGN KEY(StateID) REFERENCES State(StateID),
    ZipID DECIMAL(12) NOT NULL,
    FOREIGN KEY(ZipID) REFERENCES Zip(ZipID),
    DateSignUp DATE NOT NULL,
    DateLastLogin DATE NOT NULL,
    MemberIsClient VARCHAR(1) NOT NULL,
    MemberIsPeer VARCHAR(1) NOT NULL
);

CREATE TABLE ClientMember(
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    Notes VARCHAR(24),
    SentGift VARCHAR(1) NOT NULL
);

CREATE TABLE PeerMember(
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    TypeOfWork VARCHAR(50),
    FacebookProfile VARCHAR(20),
    LinkedInProfile VARCHAR(20)
);

CREATE TABLE Offering(
    OfferingID DECIMAL(12) NOT NULL PRIMARY KEY,
    OfferingType VARCHAR(7) NOT NULL,
    Name VARCHAR(32) NOT NULL,
    Description VARCHAR(1000),
    PictureLink VARCHAR(50),
    Price DECIMAL(8, 2) NOT NULL
);

CREATE TABLE ProductOffering(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    Warranty VARCHAR(500),
    Supply DECIMAL(4) NOT NULL
);

CREATE TABLE RentalOffering(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    RentalDurationDays DECIMAL(2) NOT NULL,
    Supply DECIMAL(4) NOT NULL
);

CREATE TABLE ServiceOffering(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    NextDateAvailable DATE
);

CREATE TABLE ClassOffering(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    NumberOfLessons DECIMAL(2) NOT NULL,
    ClassType VARCHAR(7) NOT NULL
);

CREATE TABLE GroupClass(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    NextDateAvailable DATE,
    ClassSize DECIMAL(2) NOT NULL
);

CREATE TABLE PrivateClass(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    AdditionalPercent DECIMAL(2, 2) NOT NULL
);

CREATE TABLE VirtualClass(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    DiscountPercent DECIMAL(2, 2) NOT NULL
);

CREATE TABLE GenericClass(
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    DiscountPercent DECIMAL(2, 2) NOT NULL,
    RefCode VARCHAR(30)
);

CREATE TABLE Transaction(
    TransactionID DECIMAL(12) NOT NULL PRIMARY KEY,
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    ShipSpeedID DECIMAL(12) NOT NULL,
    FOREIGN KEY(ShipSpeedID) REFERENCES ShipSpeed(ShipSpeedID),
	PurchaseID DECIMAL(12) NOT NULL,
    FOREIGN KEY(PurchaseID) REFERENCES Purchase(PurchaseID)
);

CREATE TABLE Lease(
    LeaseID DECIMAL(12) NOT NULL PRIMARY KEY,
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
    ShipSpeedID DECIMAL(12) NOT NULL,
    FOREIGN KEY(ShipSpeedID) REFERENCES ShipSpeed(ShipSpeedID),
	PurchaseID DECIMAL(12) NOT NULL,
    FOREIGN KEY(PurchaseID) REFERENCES Purchase(PurchaseID),
	StartDate DATE NOT NULL
);

CREATE TABLE Session(
    SessionID DECIMAL(12) NOT NULL PRIMARY KEY,
    SessionDateTime DATE,
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
	PurchaseID DECIMAL(12) NOT NULL,
    FOREIGN KEY(PurchaseID) REFERENCES Purchase(PurchaseID)
);

CREATE TABLE Lesson(
    LessonID DECIMAL(12) NOT NULL PRIMARY KEY,
    LessonDateTime DATE,
    MemberID DECIMAL(12) NOT NULL,
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
    OfferingID DECIMAL(12) NOT NULL,
    FOREIGN KEY(OfferingID) REFERENCES Offering(OfferingID),
	PurchaseID DECIMAL(12) NOT NULL,
    FOREIGN KEY(PurchaseID) REFERENCES Purchase(PurchaseID)
);

-- Create All Sequences
CREATE SEQUENCE purchase_seq START WITH 1;
CREATE SEQUENCE purchaseamounthistory_seq START WITH 1;
CREATE SEQUENCE zip_seq START WITH 1;
CREATE SEQUENCE city_seq START WITH 1;
CREATE SEQUENCE state_seq START WITH 1;
CREATE SEQUENCE member_seq START WITH 1;
CREATE SEQUENCE transaction_seq START WITH 1;
CREATE SEQUENCE shipspeed_seq START WITH 1;
CREATE SEQUENCE lease_seq START WITH 1;
CREATE SEQUENCE session_seq START WITH 1;
CREATE SEQUENCE lesson_seq START WITH 1;
CREATE SEQUENCE offering_seq START WITH 1;

-- Create All Foreign Key Indexes
CREATE INDEX member_cityid_idx ON Member(CityID);
CREATE INDEX member_stateid_idx ON Member(StateID);
CREATE INDEX member_zipid_idx ON Member(ZipID);
CREATE UNIQUE INDEX clientmember_memberid_idx ON ClientMember(MemberID);
CREATE UNIQUE INDEX peermember_memberid_idx ON PeerMember(MemberID);
CREATE INDEX purchaseamounthistory_purchaseid_idx ON PurchaseAmountHistory(PurchaseID);
CREATE INDEX transaction_memberid_idx ON Transaction(MemberID);
CREATE INDEX transaction_offeringid_idx ON Transaction(OfferingID);
CREATE INDEX transaction_shipspeedid_idx ON Transaction(ShipSpeedID);
CREATE INDEX transaction_purchaseid_idx ON Transaction(PurchaseID);
CREATE INDEX lease_memberid_idx ON Lease(MemberID);
CREATE INDEX lease_offeringid_idx ON Lease(OfferingID);
CREATE INDEX lease_shipspeedid_idx ON Lease(ShipSpeedID);
CREATE INDEX lease_purchaseid_idx ON Lease(PurchaseID);
CREATE INDEX session_memberid_idx ON Session(MemberID);
CREATE INDEX session_offeringid_idx ON Session(OfferingID);
CREATE INDEX session_purchaseid_idx ON Session(PurchaseID);
CREATE INDEX lesson_memberid_idx ON Lesson(MemberID);
CREATE INDEX lesson_offeringid_idx ON Lesson(OfferingID);
CREATE INDEX lesson_purchaseid_idx ON Lesson(PurchaseID);
CREATE UNIQUE INDEX productoffering_offeringid_idx ON ProductOffering(OfferingID);
CREATE UNIQUE INDEX rentaloffering_offeringid_idx ON RentalOffering(OfferingID);
CREATE UNIQUE INDEX serviceoffering_offeringid_idx ON ServiceOffering(OfferingID);
CREATE UNIQUE INDEX classoffering_offeringid_idx ON ClassOffering(OfferingID);
CREATE UNIQUE INDEX groupclass_offeringid_idx ON GroupClass(OfferingID);
CREATE UNIQUE INDEX privateclass_offeringid_idx ON PrivateClass(OfferingID);
CREATE UNIQUE INDEX virtualclass_offeringid_idx ON VirtualClass(OfferingID);
CREATE UNIQUE INDEX genericclass_offeringid_idx ON GenericClass(OfferingID);

-- Create All Query Driven Indexes
CREATE UNIQUE INDEX purchase_purchaseconf_idx ON Purchase(PurchaseConf);
CREATE INDEX member_firstname_idx ON Member(FirstName);
CREATE INDEX lesson_lessondatetime_idx ON Lesson(LessonDateTime);

-- Create Trigger Function
CREATE OR REPLACE FUNCTION PurchaseChangeFunction()
RETURNS TRIGGER LANGUAGE plpgsql AS
$trigfunc$
	BEGIN
		INSERT INTO PurchaseAmountHistory(AmountChangeID, OldAmount, NewAmount, PurchaseID, ChangeDate)
		VALUES	(nextval('purchaseamounthistory_seq'),
				 OLD.Amount,
				 NEW.Amount,
				 New.PurchaseID,
				 CURRENT_DATE);
	RETURN NEW;
	END;
$trigfunc$;

CREATE TRIGGER PurchaseChangeTrigger
BEFORE UPDATE OF Amount ON Purchase
FOR EACH ROW
EXECUTE PROCEDURE PurchaseChangeFunction();
