-- DVT Database
CREATE DATABASE DVT;
USE DVT;

-- Participants Table
CREATE TABLE Participants (
    Participant_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL CHECK (CHAR_LENGTH(State) = 2),
    Zip VARCHAR(10) NOT NULL CHECK (Zip REGEXP '^[0-9]{5}$'),
    Age INT NOT NULL CHECK (Age BETWEEN 18 AND 113),
    Gender VARCHAR(50) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
    Enrollment_Site VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(50) NOT NULL CHECK (Phone_Number REGEXP '^[A-Za-z0-9 ()+.,xX/-]*$'),
    Email VARCHAR(100) NOT NULL UNIQUE CHECK (Email LIKE '%_@_%._%')
);

-- Health Metrics Table
CREATE TABLE Health_Metrics (
    Metric_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Participant_ID INT NOT NULL,
    Metric_Date_Entered DATETIME NOT NULL,
    Blood_Pressure VARCHAR(15) CHECK (Blood_Pressure REGEXP '^[0-9]+/[0-9]+ mmHg$'),
    Blood_SugarLevels VARCHAR(15) CHECK (Blood_SugarLevels REGEXP '^[0-9]+(\\.[0-9]{1,2})? mg/dL$'),
    BMI DECIMAL(5,2) CHECK (BMI BETWEEN 10 AND 60),
    FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID) ON DELETE CASCADE
);

-- Treatment Regimen Table
CREATE TABLE Treatment_Regimen (
    Treatment_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Participant_ID INT NOT NULL,
    Drug_Name VARCHAR(50) NOT NULL,
    Dosage DECIMAL(5,2) NOT NULL CHECK (Dosage > 0),
    Admin_Schedule VARCHAR(50) NOT NULL,
    FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID) ON DELETE CASCADE
);

-- Adverse Events Table
CREATE TABLE Adverse_Events (
    Event_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Participant_ID INT NOT NULL,
    Event_Date_Entered DATETIME NOT NULL,
    Event_Type VARCHAR(50) NOT NULL,
    Severity ENUM('Mild', 'Moderate', 'Severe') NOT NULL,
    Resolution_Status ENUM('Resolved', 'Pending', 'Unresolved') NOT NULL,
    FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID) ON DELETE CASCADE
);

-- Follow-up and Imaging Table
CREATE TABLE FollowUp_Imaging (
    Imaging_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Participant_ID INT NOT NULL,
    Imaging_Date_Entered DATETIME NOT NULL,
    Imaging_Type VARCHAR(50) NOT NULL CHECK (Imaging_Type IN ('Ultrasound', 'CT Scan', 'MRI', 'X-Ray', 'Other')),
	ThrombusProp_Status VARCHAR(50) NOT NULL CHECK (ThrombusProp_Status IN ('Present', 'Not Present')),
    FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID) ON DELETE CASCADE
);

-- JOIN
SELECT 
    p.Participant_ID,
    p.First_Name,
    p.Last_Name,
    h.Metric_Date_Entered,
    h.Blood_Pressure,
    h.Blood_SugarLevels,
    h.BMI
FROM Participants p
JOIN Health_Metrics h ON p.Participant_ID = h.Participant_ID;

SELECT 
    p.Participant_ID,
    p.First_Name,
    p.Last_Name,
    t.Drug_Name,
    t.Dosage,
    t.Admin_Schedule
FROM Participants p
JOIN Treatment_Regimen t ON p.Participant_ID = t.Participant_ID;

SELECT 
    p.Participant_ID,
    p.First_Name,
    p.Last_Name,
    a.Event_Date_Entered,
    a.Event_Type,
    a.Severity,
    a.Resolution_Status
FROM Participants p
JOIN Adverse_Events a ON p.Participant_ID = a.Participant_ID;

SELECT 
    p.Participant_ID,
    p.First_Name,
    p.Last_Name,
    f.Imaging_Date_Entered,
    f.Imaging_Type,
    f.ThrombusProp_Status
FROM Participants p
JOIN FollowUp_Imaging f ON p.Participant_ID = f.Participant_ID;

-- SELECT
SELECT AVG(BMI) AS Average_BMI
FROM Health_Metrics;

SELECT Enrollment_Site, COUNT(*) AS Num_Participants
FROM Participants
GROUP BY Enrollment_Site;

SELECT First_Name, Last_Name, Age, Gender
FROM Participants
WHERE Age > 50 AND Gender = 'Female';

SELECT Participant_ID, Imaging_Type, Imaging_Date_Entered
FROM FollowUp_Imaging
WHERE Imaging_Type IN ('MRI', 'CT Scan');

-- INSERT
INSERT INTO Participants (
    Participant_ID, First_Name, Last_Name, Address, City, State, Zip,
    Age, Gender, Enrollment_Site, Phone_Number, Email
) VALUES
(1, 'Melissa', 'Brown', '22035 Joseph Valleys', 'Johnsonstad', 'ME', '61409', 69, 'Female', 'Walton-Sims', '001-370-929-9131x46913', 'gwendolynmartinez@oconnor.com'),
(2, 'Randy', 'Mayo', '4457 Ashley Springs', 'New Jamie', 'MI', '35718', 44, 'Male', 'Smith-Perez', '001-321-377-7467x75589', 'williamscarlos@cox.com'),
(3, 'Jodi', 'Sanchez', '0159 Anderson Corners Apt. 330', 'Port Tommouth', 'AR', '79359', 52, 'Other', 'Berg Ltd', '+1-223-102-1708x024', 'ericmann@robles.com'),
(4, 'Patricia', 'Cook', '1546 Smith Island Suite 368', 'Lawsonside', 'IL', '25809', 34, 'Other', 'Patterson, Deleon and Lopez', '164.463.5619x46362', 'kwilson@lewis.org'),
(5, 'Cody', 'Fields', '7478 Kelly Shoal', 'Brownborough', 'NM', '93240', 37, 'Male', 'Pratt-White', '413.014.1023x571', 'christopher13@yahoo.com'),
(6, 'Jason', 'Stokes', '47534 Sanchez Brook Apt. 024', 'Blackburnborough', 'RI', '85816', 29, 'Other', 'Escobar-Wall', '(070)886-3324x882', 'andreamcmahon@gmail.com'),
(7, 'Christopher', 'Yates', '72306 Martin Lock', 'East Adrienneburgh', 'CA', '55553', 50, 'Male', 'Powers, Shah and Espinoza', '317-286-8577', 'ericnavarro@gmail.com'),
(8, 'Corey', 'Mata', '16519 Theodore Forges', 'Lake Nicholaschester', 'ME', '66325', 56, 'Female', 'Johnson PLC', '119.263.1152', 'ramirezdanielle@miller-hart.org'),
(9, 'John', 'Smith', '84201 Hunter Curve Apt. 340', 'Flemingmouth', 'ME', '27184', 78, 'Other', 'Price, Snyder and Hernandez', '501-863-2570', 'jenniferperry@foley-norris.com'),
(10, 'Megan', 'Pope', '9137 Martinez River Apt. 594', 'South Brittanyview', 'AL', '93892', 28, 'Other', 'Andrews Group', '629.249.1994x12277', 'ghernandez@martin.com');

SELECT * FROM Participants;

INSERT INTO Health_Metrics (
    Metric_ID, Participant_ID, Metric_Date_Entered, Blood_Pressure, Blood_SugarLevels, BMI
) VALUES
(1, 1, '2025-02-20 07:51:09', '101/85 mmHg', '117.01 mg/dL', 24.93),
(2, 2, '2025-01-22 10:57:33', '139/87 mmHg', '92.47 mg/dL', 30.01),
(3, 3, '2025-02-18 04:41:13', '93/88 mmHg', '114.92 mg/dL', 30.84),
(4, 4, '2025-01-14 16:44:13', '138/62 mmHg', '126.14 mg/dL', 19.88),
(5, 5, '2025-01-14 10:48:56', '127/77 mmHg', '94.09 mg/dL', 30.56),
(6, 6, '2025-01-26 01:05:25', '110/79 mmHg', '122.48 mg/dL', 31.96),
(7, 7, '2025-02-16 16:10:09', '124/64 mmHg', '90.4 mg/dL', 27.24),
(8, 8, '2025-01-21 07:46:16', '122/75 mmHg', '116.68 mg/dL', 19.81),
(9, 9, '2025-01-27 03:19:01', '133/70 mmHg', '146.95 mg/dL', 27.65),
(10, 10, '2025-01-02 22:24:32', '95/63 mmHg', '71.6 mg/dL', 32.77);

SELECT * FROM Health_Metrics;

INSERT INTO Treatment_Regimen (
    Treatment_ID, Participant_ID, Drug_Name, Dosage, Admin_Schedule
) VALUES
(1, 1, 'Particular', 329.84, 'Weekly'),
(2, 1, 'Social', 23.86, 'As needed'),
(3, 3, 'Probably', 310.04, 'As needed'),
(4, 4, 'Hundred', 491.41, 'Weekly'),
(5, 5, 'More', 290.45, 'Weekly'),
(6, 6, 'Us', 220.27, 'As needed'),
(7, 7, 'Card', 20.33, 'As needed'),
(8, 8, 'Purpose', 480.16, 'As needed'),
(9, 9, 'Early', 420.48, 'As needed'),
(10, 10, 'Traditional', 484.02, 'Weekly');

SELECT * FROM Treatment_Regimen;

INSERT INTO Adverse_Events (
    Event_ID, Participant_ID, Event_Date_Entered, Event_Type, Severity, Resolution_Status
) VALUES
(1, 1, '2025-03-09 03:35:39', 'Fatigue', 'Severe', 'Pending'),
(2, 2, '2025-03-19 12:17:26', 'Dizziness', 'Severe', 'Pending'),
(3, 3, '2025-02-25 04:12:58', 'Fatigue', 'Mild', 'Resolved'),
(4, 4, '2025-03-15 06:40:14', 'Headache', 'Moderate', 'Resolved'),
(5, 5, '2025-01-31 23:41:01', 'Dizziness', 'Severe', 'Pending'),
(6, 6, '2025-02-12 18:13:33', 'Nausea', 'Mild', 'Resolved'),
(7, 7, '2025-01-02 20:34:42', 'Nausea', 'Mild', 'Resolved'),
(8, 8, '2025-02-18 16:08:15', 'Dizziness', 'Moderate', 'Pending'),
(9, 9, '2025-02-02 19:44:45', 'Fatigue', 'Mild', 'Resolved'),
(10, 10, '2025-03-02 03:45:42', 'Dizziness', 'Severe', 'Pending');

SELECT * FROM Adverse_Events;

INSERT INTO FollowUp_Imaging (
    Imaging_ID, Participant_ID, Imaging_Date_Entered, Imaging_Type, ThrombusProp_Status
) VALUES
(1, 1, '2025-01-06 17:18:39', 'Ultrasound', 'Present'),
(2, 2, '2025-03-19 18:57:48', 'X-ray', 'Not Present'),
(3, 3, '2025-03-01 16:59:11', 'CT Scan', 'Present'),
(4, 4, '2025-01-15 03:22:35', 'MRI', 'Not Present'),
(5, 5, '2025-02-27 18:23:10', 'X-ray', 'Present'),
(6, 6, '2025-02-13 12:23:50', 'X-ray', 'Not Present'),
(7, 7, '2025-01-30 16:48:41', 'CT Scan', 'Present'),
(8, 8, '2025-02-02 10:46:42', 'CT Scan', 'Not Present'),
(9, 9, '2025-03-10 17:56:14', 'MRI', 'Present'),
(10, 10, '2025-03-19 04:21:47', 'CT Scan', 'Not Present');

SELECT * FROM FollowUp_Imaging;

-- Trigger Functions:

DELIMITER //

CREATE TRIGGER before_insert_participant_email
BEFORE INSERT ON Participants
FOR EACH ROW
SET NEW.Email = LOWER(NEW.Email);
//

DELIMITER ;

INSERT INTO Participants (
    First_Name, Last_Name, Address, City, State, Zip,
    Age, Gender, Enrollment_Site, Phone_Number, Email
) VALUES (
    'Joel', 'Prosper', '1234 Way', 'Orlando', 'FL', '32816',
    50, 'Male', 'Walton-Sims', '111-370-929-9131x46913', 'TeStEmaIL@GmaiL.cOm'
);

SELECT Email FROM Participants WHERE First_Name = 'Joel';

-- STORED PROCEDURE: sp_InsertParticipant
-- Inserts a new participant with validation feedback.

DELIMITER $$

CREATE PROCEDURE sp_InsertParticipant (
    IN p_First_Name VARCHAR(50),
    IN p_Last_Name VARCHAR(50),
    IN p_Address VARCHAR(100),
    IN p_City VARCHAR(50),
    IN p_State VARCHAR(2),
    IN p_Zip VARCHAR(10),
    IN p_Age INT,
    IN p_Gender VARCHAR(50),
    IN p_Enrollment_Site VARCHAR(50),
    IN p_Phone_Number VARCHAR(50),
    IN p_Email VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Could not insert participant. Check input constraints.' AS Message;
    END;

    INSERT INTO Participants (
        First_Name, Last_Name, Address, City, State, Zip,
        Age, Gender, Enrollment_Site, Phone_Number, Email
    )
    VALUES (
        p_First_Name, p_Last_Name, p_Address, p_City, p_State, p_Zip,
        p_Age, p_Gender, p_Enrollment_Site, p_Phone_Number, p_Email
    );

    SELECT CONCAT('Participant ', p_First_Name, ' ', p_Last_Name, ' inserted successfully.') AS Message;
END$$

DELIMITER ;

-- STORED PROCEDURE: sp_GetParticipantHealthSummary
-- Retrieves the most recent health metrics for a given participant.

DELIMITER $$

CREATE PROCEDURE sp_GetParticipantHealthSummary (
    IN p_Participant_ID INT
)
BEGIN
    SELECT 
        p.Participant_ID,
        p.First_Name,
        p.Last_Name,
        h.Metric_Date_Entered,
        h.Blood_Pressure,
        h.Blood_SugarLevels,
        h.BMI
    FROM Participants p
    JOIN Health_Metrics h ON p.Participant_ID = h.Participant_ID
    WHERE p.Participant_ID = p_Participant_ID
    ORDER BY h.Metric_Date_Entered DESC
    LIMIT 1;
END$$

DELIMITER ;

-- STORED PROCEDURE: sp_ReportAdverseEvents
-- Generates a report of adverse events, optionally filtered by severity.

DELIMITER $$

CREATE PROCEDURE sp_ReportAdverseEvents (
    IN p_Severity VARCHAR(10)
)
BEGIN
    IF p_Severity IS NULL OR p_Severity = '' THEN
        SELECT 
            p.Participant_ID,
            p.First_Name,
            p.Last_Name,
            a.Event_Date_Entered,
            a.Event_Type,
            a.Severity,
            a.Resolution_Status
        FROM Participants p
        JOIN Adverse_Events a ON p.Participant_ID = a.Participant_ID;
    ELSE
        SELECT 
            p.Participant_ID,
            p.First_Name,
            p.Last_Name,
            a.Event_Date_Entered,
            a.Event_Type,
            a.Severity,
            a.Resolution_Status
        FROM Participants p
        JOIN Adverse_Events a ON p.Participant_ID = a.Participant_ID
        WHERE a.Severity = p_Severity;
    END IF;
END$$

DELIMITER ;

-- STORED PROCEDURE: sp_GetImagingFollowUp
-- Shows all imaging results for a participant, with an optional filter for thrombus presence.

DELIMITER $$

CREATE PROCEDURE sp_GetImagingFollowUp (
    IN p_Participant_ID INT,
    IN p_ThrombusStatus VARCHAR(20)
)
BEGIN
    SELECT 
        f.Imaging_ID,
        f.Imaging_Date_Entered,
        f.Imaging_Type,
        f.ThrombusProp_Status
    FROM FollowUp_Imaging f
    WHERE f.Participant_ID = p_Participant_ID
    AND (p_ThrombusStatus IS NULL OR f.ThrombusProp_Status = p_ThrombusStatus)
    ORDER BY f.Imaging_Date_Entered DESC;
END$$

DELIMITER ;

-- CALLING ALL STORED PROCEDURE
-- Insert a participant
CALL sp_InsertParticipant('Sarah', 'Jones', '123 Elm St', 'Dallas', 'TX', '75201', 45, 'Female', 'Site-A', '555-1234', 'sarah.jones@example.com');

-- Get most recent health metrics
CALL sp_GetParticipantHealthSummary(1);

-- Report all severe adverse events
CALL sp_ReportAdverseEvents('Severe');

-- Imaging follow-up with filter
CALL sp_GetImagingFollowUp(3, 'Present');