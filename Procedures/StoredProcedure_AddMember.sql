CREATE OR REPLACE PROCEDURE AddMember(
    p_FirstName IN VARCHAR,
    p_LastName IN VARCHAR,
    p_Email IN VARCHAR,
    p_Phone IN VARCHAR,
    p_StreetAddress IN VARCHAR,
    p_CityName IN VARCHAR,
    p_StateAbbrv IN VARCHAR,
    p_Zip IN VARCHAR,
    p_MemberIsClient IN VARCHAR,
    p_MemberIsPeer IN VARCHAR,
    p_TypeOfWork IN VARCHAR DEFAULT NULL,
    p_FacebookProfile IN VARCHAR DEFAULT NULL,
    p_LinkedInProfile IN VARCHAR DEFAULT NULL
) LANGUAGE plpgsql AS $proc1$

DECLARE
    v_CityID DECIMAL(12);
    v_StateID DECIMAL(12);
    v_ZipID DECIMAL(12);
BEGIN
    -- Find or Add the CityID
    SELECT CityID
    INTO v_CityID
    FROM City
    WHERE p_CityName = City.CityName;

    IF v_CityID IS NULL THEN
        INSERT INTO City(CityID, CityName)
        VALUES(nextval('city_seq'), p_CityName);
        v_CityID = currval('city_seq');
    END IF;

    -- Find the StateID
    SELECT StateID
    INTO v_StateID
    FROM State
    WHERE p_StateAbbrv = State.StateAbbrv;

    IF v_StateID IS NULL THEN
        RAISE;
    END IF;

    -- Find or Add the ZipID
    SELECT ZipID
    INTO v_ZipID
    FROM Zip
    WHERE p_Zip = Zip.ZipNumber;

    IF v_ZipID IS NULL THEN
        INSERT INTO Zip(ZipID, ZipNumber)
        VALUES(nextval('zip_seq'), p_Zip);
        v_ZipID = currval('zip_seq');
    END IF;

    INSERT INTO Member(MemberID, FirstName, LastName, Email, Phone, Address, CityID, StateID, ZipID, DateSignUp, DateLastLogin, MemberIsClient, MemberIsPeer)
    VALUES(nextval('member_seq'), p_FirstName, p_LastName, p_Email, p_Phone, p_StreetAddress, v_CityID, v_StateID, v_ZipID, CURRENT_DATE, CURRENT_DATE, p_MemberIsClient, p_MemberIsPeer);

    IF p_MemberIsClient = 'T' THEN
        INSERT INTO ClientMember(MemberID, Notes, SentGift)
        VALUES(currval('member_seq'), NULL, 'F');
    END IF;

    IF p_MemberIsPeer = 'T' THEN
        INSERT INTO PeerMember(MemberID, TypeOfWork, FacebookProfile, LinkedInProfile)
        VALUES(currval('member_seq'), p_TypeOfWork, p_FacebookProfile, p_LinkedInProfile);
    END IF;
END;
$proc1$;

START TRANSACTION;
DO
    $$ BEGIN
        CALL AddMember('Aaron', 'Apples', 'aa@gmail.com', '123-456-7890', 'Avenue A', 'Annapolis', 'AZ', '01234', 'T', 'F');
    END $$;
COMMIT TRANSACTION;
