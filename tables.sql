CREATE DATABASE organ_transplant_system;
USE organ_transplant_system;

DROP TABLE IF EXISTS login, Recipient, Recipient_phone_no, Institution, Surgeon, Receiver, Contributor, Organ_inventory, Matching, Institution_phone_no, Surgeon_phone_no, Institution_head, log;

CREATE TABLE login(
    username VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL
);

INSERT INTO login VALUES ('admin','admin');

CREATE TABLE Recipient(
    Recipient_ID int NOT NULL,
    Name varchar(20) NOT NULL,
    Date_of_Birth date NOT NULL,
    Medical_insurance int,
    Medical_history varchar(20),
    Street varchar(20),
    City varchar(20),
    State varchar(20),
    PRIMARY KEY(Recipient_ID)
);

CREATE TABLE Recipient_phone_no(
    Recipient_ID int NOT NULL,
    phone_no varchar(15),
    FOREIGN KEY(Recipient_ID) REFERENCES Recipient(Recipient_ID) ON DELETE CASCADE
);

CREATE TABLE Institution(
    Institution_ID int NOT NULL,
    Institution_name varchar(20) NOT NULL,
    Location varchar(20),
    Government_approved int,
    PRIMARY KEY(Institution_ID)
);

CREATE TABLE Surgeon(
    Surgeon_ID int NOT NULL,
    Surgeon_Name varchar(20) NOT NULL,
    Department_Name varchar(20) NOT NULL,
    Institution_ID int NOT NULL,
    FOREIGN KEY(Institution_ID) REFERENCES Institution(Institution_ID) ON DELETE CASCADE,
    PRIMARY KEY(Surgeon_ID)
);

CREATE TABLE Receiver(
    Receiver_ID int NOT NULL,
    required_organ varchar(20) NOT NULL,
    reason_of_procurement varchar(20),
    Surgeon_ID int NOT NULL,
    Recipient_ID int NOT NULL,
    FOREIGN KEY(Recipient_ID) REFERENCES Recipient(Recipient_ID) ON DELETE CASCADE,
    FOREIGN KEY(Surgeon_ID) REFERENCES Surgeon(Surgeon_ID) ON DELETE CASCADE,
    PRIMARY KEY(Receiver_ID, required_organ)
);

CREATE TABLE Contributor(
    Contributor_ID int NOT NULL,
    donated_organ varchar(20) NOT NULL,
    reason_of_donation varchar(20),
    Institution_ID int NOT NULL,
    Recipient_ID int NOT NULL,
    FOREIGN KEY(Recipient_ID) REFERENCES Recipient(Recipient_ID) ON DELETE CASCADE,
    FOREIGN KEY(Institution_ID) REFERENCES Institution(Institution_ID) ON DELETE CASCADE,
    PRIMARY KEY(Contributor_ID, donated_organ)
);

CREATE TABLE Organ_inventory(
    Organ_ID int NOT NULL AUTO_INCREMENT,
    Organ_name varchar(20) NOT NULL,
    Contributor_ID int NOT NULL,
    FOREIGN KEY(Contributor_ID) REFERENCES Contributor(Contributor_ID) ON DELETE CASCADE,
    PRIMARY KEY(Organ_ID)
);

CREATE TABLE Matching(
    Receiver_ID int NOT NULL,
    Organ_ID int NOT NULL,
    Contributor_ID int NOT NULL,
    Date_of_matching date NOT NULL,
    Status int NOT NULL,
    FOREIGN KEY(Receiver_ID) REFERENCES Receiver(Receiver_ID) ON DELETE CASCADE,
    FOREIGN KEY(Contributor_ID) REFERENCES Contributor(Contributor_ID) ON DELETE CASCADE,
    PRIMARY KEY(Receiver_ID, Organ_ID)
);

CREATE TABLE Institution_phone_no(
    Institution_ID int NOT NULL,
    Phone_no varchar(15),
    FOREIGN KEY(Institution_ID) REFERENCES Institution(Institution_ID) ON DELETE CASCADE
);

CREATE TABLE Surgeon_phone_no(
    Surgeon_ID int NOT NULL,
    Phone_no varchar(15),
    FOREIGN KEY(Surgeon_ID) REFERENCES Surgeon(Surgeon_ID) ON DELETE CASCADE
);

CREATE TABLE Institution_head(
    Institution_ID int NOT NULL,
    Employee_ID int NOT NULL,
    Name varchar(20) NOT NULL,
    Date_of_joining date NOT NULL,
    Term_length int NOT NULL,
    FOREIGN KEY(Institution_ID) REFERENCES Institution(Institution_ID) ON DELETE CASCADE,
    PRIMARY KEY(Institution_ID, Employee_ID)
);

CREATE TABLE log (
    querytime datetime,
    comment varchar(255)
);


INSERT INTO Recipient (Recipient_ID, Name, Date_of_Birth, Medical_insurance, Medical_history, Street, City, State)
VALUES (1, 'Riya Sharma', '2001-06-12', 115389, 'Kidney Disorder', '221B Baker Street', 'Delhi', 'Delhi');
INSERT INTO Institution (Institution_ID, Institution_name, Location, Government_approved)
VALUES (100, 'AIIMS', 'Delhi', 1);
INSERT INTO Surgeon (Surgeon_ID, Surgeon_Name, Department_Name, Institution_ID)
VALUES (201, 'Dr. Mehta', 'Transplant Surgery', 100);


-- Admin login
INSERT INTO login (username, password) VALUES
('admin', 'admin123');

-- Institutions
INSERT INTO Institution (institution_id, name, address) VALUES
(1, 'Apollo Hospital', 'Delhi'),
(2, 'Fortis Hospital', 'Mumbai');

-- Surgeons
INSERT INTO Surgeon (surgeon_id, name, specialization, institution_id) VALUES
(1, 'Dr. Mehta', 'Cardiology', 1),
(2, 'Dr. Sen', 'Nephrology', 2);

-- Contributors (donors)
INSERT INTO Contributor (contributor_id, name, dob, gender, blood_group, organ_donated, contact_person, contact_phone, date_of_donation, institution_id) VALUES
(1, 'Ravi Kumar', '1980-04-12', 'Male', 'O+', 'Kidney', 'Anita', '9876543210', '2024-12-15', 1),
(2, 'Sunita Sharma', '1975-07-20', 'Female', 'A+', 'Heart', 'Rajesh', '9876543222', '2025-01-10', 2);

-- Contributor phone numbers
INSERT INTO Contributor_Phone (contributor_id, phone_number) VALUES
(1, '9876543210'),
(2, '9876543222');

-- Receivers (recipients who received the organ)
INSERT INTO Receiver (receiver_id, name, dob, gender, blood_group, organ_received, date_of_transplant, surgeon_id, institution_id) VALUES
(1, 'Vikram Singh', '1990-02-01', 'Male', 'O+', 'Kidney', '2024-12-20', 1, 1);

-- Recipients (waiting list)
INSERT INTO Recipient (recipient_id, name, dob, gender, blood_group, organ_required, priority_level, institution_id) VALUES
(1, 'Neha Jain', '1995-06-18', 'Female', 'A+', 'Heart', 'High', 2);

-- Recipient phone
INSERT INTO Recipient_Phone (recipient_id, phone_number) VALUES
(1, '9012345678');

-- Logs (optional)
INSERT INTO Logs (log_id, action, timestamp) VALUES
(1, 'Initial data insert', NOW());
