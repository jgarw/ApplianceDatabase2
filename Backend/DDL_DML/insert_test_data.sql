-- Insert test data into CUSTOMERS_VIEW
INSERT INTO CUSTOMERS_VIEW (firstName, lastName, email, phone)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890');

INSERT INTO CUSTOMERS_VIEW (firstName, lastName, email, phone)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', '9876543210');

INSERT INTO CUSTOMERS_VIEW (firstName, lastName, email, phone)
VALUES ('Alice', 'Johnson', 'alice.johnson@example.com', '5555555555');

-- Verify CUSTOMERS_VIEW data inserted correctly
SELECT * FROM CUSTOMERS_VIEW;

-- Inserting test data into APPLIANCES table
INSERT INTO APPLIANCES (applianceType, applianceName) VALUES ('Refrigerator', 'Samsung Fridge');
INSERT INTO APPLIANCES (applianceType, applianceName) VALUES ('Washing Machine', 'LG Washer');
INSERT INTO APPLIANCES (applianceType, applianceName) VALUES ('Dishwasher', 'Bosch Dishwasher');

-- Inserting test data into TECHNICIANS table
INSERT INTO TECHNICIANS (technicianName, technicianSpecialty) VALUES ('Alice', 'Refrigerator Repair');
INSERT INTO TECHNICIANS (technicianName, technicianSpecialty) VALUES ('Bob', 'Washing Machine Installation');
INSERT INTO TECHNICIANS (technicianName, technicianSpecialty) VALUES ('Charlie', 'Dishwasher Maintenance');

-- Inserting test data into CUST_APPLIANCES table
INSERT INTO CUST_APPLIANCES (customerID, applianceID) VALUES (1, 1);
INSERT INTO CUST_APPLIANCES (customerID, applianceID) VALUES (2, 2);
INSERT INTO CUST_APPLIANCES (customerID, applianceID) VALUES (3, 3);

-- Inserting test data into APPOINTMENTS_VIEW
INSERT INTO APPOINTMENTS_VIEW (customerID, applianceID, technicianID, datetime, reason, quote) VALUES (1, 1, 1, SYSTIMESTAMP, 'Repair', 100.00);
INSERT INTO APPOINTMENTS_VIEW (customerID, applianceID, technicianID, datetime, reason, quote) VALUES (2, 2, 2, SYSTIMESTAMP, 'Installation', 150.00);
INSERT INTO APPOINTMENTS_VIEW (customerID, applianceID, technicianID, datetime, reason, quote) VALUES (3, 3, 3, SYSTIMESTAMP, 'Maintenance', 80.00);

-- Verify APPOINTMENTS_VIEW data inserted correctly
SELECT * FROM APPOINTMENTS_VIEW;