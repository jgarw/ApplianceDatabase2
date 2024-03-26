-- Student: Joseph Garwood

-- create a sequence to use as customerID auto-incrementor
CREATE SEQUENCE customerID_SEQ
START WITH 1
  INCREMENT BY 1;
  
-- Create a trigger on CUSTOMERS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER customersID_incrementor
BEFORE INSERT ON CUSTOMERS
FOR EACH ROW
BEGIN
  :NEW.customerID := customerID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as customer_fnameID auto-incrementor
CREATE SEQUENCE customer_fname_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on CUSTOMERS_FNAMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER customerfnameID_incrementor
BEFORE INSERT ON CUSTOMER_FNAMES
FOR EACH ROW
BEGIN
  :NEW.customer_fnameID := customer_fname_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as fnameID auto-incrementor
CREATE SEQUENCE fnameID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on FNAMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER fnameID_incrementor
BEFORE INSERT ON FNAMES
FOR EACH ROW
BEGIN
  :NEW.fnameID := fnameID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as lnameID auto-incrementor
CREATE SEQUENCE lnameID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on LNAMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER lnameID_incrementor
BEFORE INSERT ON LNAMES
FOR EACH ROW
BEGIN
  :NEW.lnameID := lnameID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as customer_lnameID auto-incrementor
CREATE SEQUENCE customer_lname_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on CUSTOMERS_LNAMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER customerlnameID_incrementor
BEFORE INSERT ON CUSTOMER_LNAMES
FOR EACH ROW
BEGIN
  :NEW.customer_lnameID := customer_lname_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as cust_appliancesID auto-incrementor
CREATE SEQUENCE cust_appliances_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on CUST_APPLIANCES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER cust_applianceID_incrementor
BEFORE INSERT ON CUST_APPLIANCES
FOR EACH ROW
BEGIN
  :NEW.cust_applianceID := cust_appliances_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as applianceID auto-incrementor
CREATE SEQUENCE applianceID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on APPLIANCES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER applianceID_incrementor
BEFORE INSERT ON APPLIANCES
FOR EACH ROW
BEGIN
  :NEW.applianceID := applianceID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as appointmentID auto-incrementor
CREATE SEQUENCE appointmentID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on APPOINTMENTS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER appointmentID_incrementor
BEFORE INSERT ON APPOINTMENTS
FOR EACH ROW
BEGIN
  :NEW.appointmentID := appointmentID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as technicianID auto-incrementor
CREATE SEQUENCE technicianID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on TECHNICIANS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER technicianID_incrementor
BEFORE INSERT ON TECHNICIANS
FOR EACH ROW
BEGIN
  :NEW.technicianID := technicianID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as appointmentdatetimeID auto-incrementor
CREATE SEQUENCE app_datetimeID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on APPOINTMENT_DATETIME table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER appointmentdatetimeID_incrementor
BEFORE INSERT ON APPOINTMENT_DATETIME
FOR EACH ROW
BEGIN
  :NEW.appointmentdatetimeID := app_datetimeID_SEQ.NEXTVAL;
END;
/

-- create a sequence to use as datetimeID auto-incrementor
CREATE SEQUENCE datetimeID_SEQ
START WITH 1
  INCREMENT BY 1; 

-- Create a trigger on DATETIMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER datetimeID_incrementor
BEFORE INSERT ON DATETIMES
FOR EACH ROW
BEGIN
  :NEW.datetimeID := datetimeID_SEQ.NEXTVAL;
END;
/

-- Create a trigger on CUSTOMERS_VIEW to insert into underlying tables
CREATE OR REPLACE TRIGGER INSERT_CUSTOMERS_VIEW
INSTEAD OF INSERT ON CUSTOMERS_VIEW
FOR EACH ROW
DECLARE
    v_fnameID FNAMES.fnameID%TYPE;
    v_lnameID LNAMES.lnameID%TYPE;
    v_customerID CUSTOMERS.customerID%TYPE;
BEGIN

    -- Insert values into underlying CUSTOMERS table with auto-generated ID
    INSERT INTO CUSTOMERS (customerID, email, phone)
    VALUES (customerID_SEQ.nextval, :NEW.email, :NEW.phone)
    RETURNING customerID INTO v_customerID;
    
    -- Insert values into underlying FNAMES table and retrieve the generated ID
    INSERT INTO FNAMES (fnameID, firstName)
    VALUES (fnameID_SEQ.nextval, :NEW.firstName)
    RETURNING fnameID INTO v_fnameID;

    -- Insert into underlying LNAMES table and retrieve the generated ID
    INSERT INTO LNAMES (lnameID, lastName)
    VALUES (lnameID_SEQ.nextval, :NEW.lastName)
    RETURNING lnameID INTO v_lnameID;
    
    -- Insert into CUSTOMER_FNAMES association table
    INSERT INTO CUSTOMER_FNAMES(customerid, fnameID, starttime, endtime)
    VALUES (v_customerID, v_fnameID, SYSTIMESTAMP, NULL);
    
    -- Insert into CUSTOMER_LNAMES association table
    INSERT INTO CUSTOMER_LNAMES(customerid, lnameID, starttime, endtime)
    VALUES (v_customerID, v_lnameID, SYSTIMESTAMP, NULL); 
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20000, 'An error occurred during insert. Insert not committed.');
END;
/

-- Create trigger on APPOINTMENTS_VIEW to insert into underlying tables
CREATE OR REPLACE TRIGGER INSERT_APPOINTMENTS_VIEW
INSTEAD OF INSERT ON APPOINTMENTS_VIEW
FOR EACH ROW
DECLARE

v_appointmentID APPOINTMENTS.appointmentID%TYPE;
v_datetimeID DATETIMES.datetimeID%TYPE;

BEGIN
    
    -- Insert into the APPOINTMENTS table
    INSERT INTO APPOINTMENTS (appointmentID, customerID, applianceID, technicianID, reason, quote)
    VALUES (appointmentID_SEQ.nextval, :NEW.customerID, :NEW.applianceID, :NEW.technicianID, :NEW.reason, :NEW.quote)
    RETURNING appointmentID INTO v_appointmentID;
    
    --Insert into DATETIMES table
    INSERT INTO DATETIMES (datetimeID, datetime)
    VALUES (datetimeID_SEQ.nextval, :NEW.datetime)
    RETURNING datetimeID INTO v_datetimeID;
    
    -- Insert into APPOINTMENT_DATETIME table
    INSERT INTO APPOINTMENT_DATETIME (appointmentdatetimeID, appointmentID, datetimeID, starttime, endtime)
    VALUES (app_datetimeID_SEQ.nextval, v_appointmentID, v_datetimeID, SYSTIMESTAMP, NULL);
    
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20000, 'An error occurred during insert. Insert not committed.');
END;
/
