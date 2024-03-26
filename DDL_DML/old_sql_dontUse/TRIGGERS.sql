-- create a sequence to use as id auto-incrementor
CREATE SEQUENCE auto_increment
START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- Create a trigger on CUSTOMERS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER customersID_incrementor
BEFORE INSERT ON CUSTOMERS
FOR EACH ROW
BEGIN
  :NEW.customerID := auto_increment.NEXTVAL;
END;
/

-- Create a trigger on CUST_APPLIANCES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER cust_applianceID_incrementor
BEFORE INSERT ON CUST_APPLIANCES
FOR EACH ROW
BEGIN
  :NEW.cust_applianceID := auto_increment.NEXTVAL;
END;
/

-- Create a trigger on APPLIANCES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER applianceID_incrementor
BEFORE INSERT ON APPLIANCES
FOR EACH ROW
BEGIN
  :NEW.applianceID := auto_increment.NEXTVAL;
END;
/


-- Create a trigger on APPOINTMENTS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER appointmentID_incrementor
BEFORE INSERT ON APPOINTMENTS
FOR EACH ROW
BEGIN
  :NEW.appointmentID := auto_increment.NEXTVAL;
END;
/

-- Create a trigger on TECHNICIANS table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER technicianID_incrementor
BEFORE INSERT ON TECHNICIANS
FOR EACH ROW
BEGIN
  :NEW.technicianID := auto_increment.NEXTVAL;
END;
/

-- Create a trigger on APPOINTMENT_DATETIME table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER appointmentdatetimeID_incrementor
BEFORE INSERT ON APPOINTMENT_DATETIME
FOR EACH ROW
BEGIN
  :NEW.appointmentdatetimeID := auto_increment.NEXTVAL;
END;
/

-- Create a trigger on DATETIMES table to use auto-incrementor on ID
CREATE OR REPLACE TRIGGER datetimeID_incrementor
BEFORE INSERT ON DATETIMES
FOR EACH ROW
BEGIN
  :NEW.datetimeID := auto_increment.NEXTVAL;
END;
/

-- Create trigger on CUSTOMERS_VIEW to insert into underlying tables 
CREATE OR REPLACE TRIGGER INSERT_CUSTOMERS_VIEW
INSTEAD OF INSERT ON CUSTOMERS_VIEW
FOR EACH ROW
DECLARE
    v_fnameID FNAMES.fnameID%TYPE;
    v_lnameID LNAMES.lnameID%TYPE;
BEGIN
    -- Insert values into underlying FNAMES table and retrieve the generated ID
    SELECT AUTO_INCREMENT.nextval INTO v_fnameID FROM dual;
    INSERT INTO FNAMES (fnameID, firstName)
    VALUES (v_fnameID, :NEW.firstName);

    -- Insert into underlying LNAMES table and retrieve the generated ID
    SELECT AUTO_INCREMENT.nextval INTO v_lnameID FROM dual;
    INSERT INTO LNAMES (lnameID, lastName)
    VALUES (v_lnameID, :NEW.lastName);
    
    -- Insert values into underlying CUSTOMERS table
    INSERT INTO CUSTOMERS (customerID, email, phone)
    VALUES (:NEW.customerID, :NEW.email, :NEW.phone);
    
    -- Insert into CUSTOMER_FNAMES association table
    INSERT INTO CUSTOMER_FNAMES(customerid, fnameID, starttime, endtime)
    VALUES (:NEW.customerID, v_fnameID, SYSTIMESTAMP, NULL);
    
    -- Insert into CUSTOMER_LNAMES association table
    INSERT INTO CUSTOMER_LNAMES(customerid, lnameID, starttime, endtime)
    VALUES (:NEW.customerID, v_lnameID, SYSTIMESTAMP, NULL); 
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20000, 'An error occurred during insert. Insert not committed.');
END;
/

