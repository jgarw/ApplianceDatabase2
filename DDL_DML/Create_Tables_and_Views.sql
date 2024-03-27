-- Student: Joseph Garwood

-- Create STORAGE
CREATE TABLESPACE assignment2
  DATAFILE 'assignment2.dat' SIZE 100M 
  ONLINE; 
  
-- Create Users
CREATE USER assignmentAdmin IDENTIFIED BY adminPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE cst2355
	QUOTA 80M ON cst2355;
	
CREATE USER testUser IDENTIFIED BY testPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE cst2355
	QUOTA 20M ON cst2355;

-- Grant PRIVILEGES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO assignmentAdmin;
GRANT CONNECT, RESOURCE TO assignmentUser;

-- Create CUSTOMERS table
CREATE TABLE CUSTOMERS (
    customerID INT PRIMARY KEY,
    email VARCHAR2(255) NOT NULL,
    phone VARCHAR2(12) NOT NULL
);

-- Create FNAMES table
CREATE TABLE FNAMES (
    fnameID INT PRIMARY KEY,
    firstName VARCHAR2(255) NOT NULL
);

-- Create LNAMES table
CREATE TABLE LNAMES (
    lnameID INT PRIMARY KEY,
    lastName VARCHAR2(255) NOT NULL
);

-- Create CUSTOMER_FNAMES table
CREATE TABLE CUSTOMER_FNAMES (
    customer_fnamesID INT PRIMARY KEY,
    customerID INT,
    fnameID INT,
    startTime TIMESTAMP,
    endTime TIMESTAMP DEFAULT NULL,
    notes VARCHAR2(255) DEFAULT NULL,
    FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID),
    FOREIGN KEY (fnameID) REFERENCES FNAMES(fnameID
);

-- Create CUSTOMER_LNAMES table
CREATE TABLE CUSTOMER_LNAMES (
    customer_lnamesID INT PRIMARY KEY,
    customerID INT,
    lnameID INT,
    startTime TIMESTAMP,
    endTime TIMESTAMP DEFAULT NULL,
    notes VARCHAR2(255) DEFAULT NULL,
    FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID),
    FOREIGN KEY (lnameID) REFERENCES LNAMES(lnameID)
);

-- Create CUSTOMERS_VIEW
CREATE VIEW CUSTOMERS_VIEW AS
SELECT c.customerID, f.firstName, l.lastName, c.email, c.phone
FROM CUSTOMERS c
JOIN CUSTOMER_FNAMES cf ON c.customerID = cf.customerID
JOIN FNAMES f ON cf.fnameID = f.fnameID
JOIN CUSTOMER_LNAMES cl ON c.customerID = cl.customerID
JOIN LNAMES l ON cl.lnameID = l.lnameID;

-- Test the new CUSTOMERS VIEW
SELECT * FROM CUSTOMERS_VIEW;

-- Recreate APPLIANCES table
CREATE TABLE APPLIANCES (
    applianceID INT PRIMARY KEY,
    applianceType VARCHAR(255) NOT NULL,
    applianceName VARCHAR(255) NOT NULL
);

-- Create CUST_APPLIANCES table
CREATE TABLE CUST_APPLIANCES (
    cust_applianceID INT PRIMARY KEY,
    customerID INT,
    applianceID INT,
    FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID),
    FOREIGN KEY (applianceID) REFERENCES appliances(applianceID)
);

-- Create APPOINTMENTS table
CREATE TABLE APPOINTMENTS (
    appointmentID INT PRIMARY KEY,
    customerID INT,
    applianceID INT,
    technicianID INT,
    reason NVARCHAR2(500),
    quote DECIMAL(10,2),
    CONSTRAINT FK_APPOINTMENT_APPLIANCE FOREIGN KEY (applianceID) REFERENCES APPLIANCES(applianceID),
    CONSTRAINT FK_APPOINTMENT_TECHNICIAN FOREIGN KEY (technicianID) REFERENCES TECHNICIANS(technicianID),
    CONSTRAINT FK_APPOINTMENT_CUSTOMER FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID)
);

-- Create DATETIME table
CREATE TABLE DATETIMES (
    dateTimeID INT PRIMARY KEY,
    dateTime TIMESTAMP NOT NULL
);

-- Create APPOINTMENT_DATETIME association table 
CREATE TABLE APPOINTMENT_DATETIME (
    appointmentDateTimeID INT PRIMARY KEY,
    appointmentID INT,
    dateTimeID INT,
    startTime TIMESTAMP,
    endTime TIMESTAMP DEFAULT NULL,
    notes VARCHAR2(255) DEFAULT NULL,
    FOREIGN KEY (appointmentID) REFERENCES APPOINTMENTS (appointmentID),
    FOREIGN KEY (dateTimeID) REFERENCES DATETIMES (dateTimeID)
);

-- Create APPOINTMENTS_VIEW
CREATE VIEW APPOINTMENTS_VIEW AS
SELECT adt.appointmentID, a.customerID, a.applianceID, a.technicianID, dt.datetime, a.reason, a.quote
FROM APPOINTMENTS a
JOIN APPOINTMENT_DATETIME adt ON a.appointmentID = adt.appointmentID
JOIN DATETIMES dt ON adt.dateTimeID = dt.dateTimeID;

-- Testing the new APPOINTMENT_DATETIME_VIEW
SELECT * FROM APPOINTMENTS_VIEW
