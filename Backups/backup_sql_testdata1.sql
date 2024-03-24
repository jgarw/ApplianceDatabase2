-- CREATE CUSTOMERS TABLE
CREATE TABLE CUSTOMERS (
    customerID INT PRIMARY KEY,
    firstName VARCHAR2(255) NOT NULL,
    lastName VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    phone VARCHAR2(12) NOT NULL
);

-- CREATE APPLIANCES TABLE
CREATE TABLE APPLIANCES (
    applianceID INT PRIMARY KEY,
    applianceName VARCHAR2(255) NOT NULL,
    applianceType VARCHAR2(255) NOT NULL
);

-- CREATE CUST_APPLIANCES JUNCTION TABLE
CREATE TABLE CUST_APPLIANCES (
    ID INT PRIMARY KEY,
    customerID NUMBER,
    applianceID NUMBER,
    CONSTRAINT FK_CUSTOMER_APPLIANCE FOREIGN KEY (applianceID) REFERENCES APPLIANCES(applianceID),
    CONSTRAINT FK_APPLIANCE_CUSTOMER FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID)
);

-- CREATE TECHNICIANS TABLE
CREATE TABLE TECHNICIANS (
    technicianID INT PRIMARY KEY,
    firstName VARCHAR2(255) NOT NULL,
    lastName VARCHAR2(255) NOT NULL
);

-- CREATE APPOINTMENTS TABLE
CREATE TABLE APPOINTMENTS (
    appointmentID INT PRIMARY KEY,
    applianceID NUMBER,
    technicianID NUMBER,
    customerID NUMBER,
    appointmentDateTime TIMESTAMP NOT NULL,
    reason NVARCHAR2(500),
    quote DECIMAL(10,2),
    CONSTRAINT FK_APPOINTMENT_APPLIANCE FOREIGN KEY (applianceID) REFERENCES APPLIANCES(applianceID),
    CONSTRAINT FK_APPOINTMENT_TECHNICIAN FOREIGN KEY (technicianID) REFERENCES TECHNICIANS(technicianID),
    CONSTRAINT FK_APPOINTMENT_CUSTOMER FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID)
);

-- Inserting data into CUSTOMERS table
INSERT INTO CUSTOMERS (customerID, firstName, lastName, email, phone)
VALUES 
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890');

INSERT INTO CUSTOMERS (customerID, firstName, lastName, email, phone)
VALUES 
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '456-789-0123');

INSERT INTO CUSTOMERS (customerID, firstName, lastName, email, phone)
VALUES 
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '789-012-3456');

-- Inserting data into APPLIANCES table
INSERT INTO APPLIANCES (applianceID, applianceName, applianceType)
VALUES 
    (1, 'Samsung 9000', 'Washing Machine');

INSERT INTO APPLIANCES (applianceID, applianceName, applianceType)
VALUES 
    (2, 'Whirlpool X300', 'Refrigerator');

INSERT INTO APPLIANCES (applianceID, applianceName, applianceType)
VALUES 
    (3, 'LG Z Series', 'Dishwasher');

-- Inserting data into CUST_APPLIANCES table
INSERT INTO CUST_APPLIANCES (ID, customerID, applianceID)
VALUES 
    (1, 1, 2); -- John Doe owns a Refrigerator

INSERT INTO CUST_APPLIANCES (ID, customerID, applianceID)
VALUES 
    (2, 2, 1); -- Jane Smith owns a Washing Machine

INSERT INTO CUST_APPLIANCES (ID, customerID, applianceID)
VALUES 
    (3, 3, 2); -- Michael Johnson also owns a Refrigerator

INSERT INTO CUST_APPLIANCES (ID, customerID, applianceID)
VALUES 
    (4, 3, 3); -- Michael Johnson owns a Dishwasher

-- Inserting data into TECHNICIANS table
INSERT INTO TECHNICIANS (technicianID, firstName, lastName)
VALUES 
    (1, 'Mark', 'Taylor');

INSERT INTO TECHNICIANS (technicianID, firstName, lastName)
VALUES 
    (2, 'Emily', 'Clark');

INSERT INTO TECHNICIANS (technicianID, firstName, lastName)
VALUES 
    (3, 'David', 'Wilson');

-- Inserting data into APPOINTMENTS table
INSERT INTO APPOINTMENTS (appointmentID, applianceID, technicianID, customerID, appointmentDateTime, reason, quote)
VALUES 
    (1, 2, 1, 1, TO_TIMESTAMP('2024-02-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refrigerator not cooling', 100.00);

INSERT INTO APPOINTMENTS (appointmentID, applianceID, technicianID, customerID, appointmentDateTime, reason, quote)
VALUES 
    (2, 1, 2, 2, TO_TIMESTAMP('2024-02-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Washing machine leaking', 75.50);

INSERT INTO APPOINTMENTS (appointmentID, applianceID, technicianID, customerID, appointmentDateTime, reason, quote)
VALUES 
    (3, 2, 3, 3, TO_TIMESTAMP('2024-02-20 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Strange noise from refrigerator', 120.00);

INSERT INTO APPOINTMENTS (appointmentID, applianceID, technicianID, customerID, appointmentDateTime, reason, quote)
VALUES 
    (4, 3, 1, 3, TO_TIMESTAMP('2024-02-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Dishwasher not draining', 85.00);

