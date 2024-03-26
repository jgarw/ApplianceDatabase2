-- Create trigger on CUSTOMERS_VIEW to insert into underlying tables 

CREATE OR REPLACE TRIGGER INSERT_CUSTOMERS_VIEW
INSTEAD OF INSERT ON CUSTOMERS_VIEW
FOR EACH ROW
BEGIN
    
    -- Insert values into underlying CUSTOMERS table
    INSERT INTO CUSTOMERS (customerID, email, phone)
    VALUES (:NEW.customerID, :NEW.email, :NEW.phone);
    
    -- Insert values into underlying FNAMES table
    INSERT INTO FNAMES (fnameID, firstName)
    VALUES (:NEW.fnameID, :NEW.firstName);
    
    -- Insert into underlying LNAMES table
    INSERT INTO LNAMES (lnameID, lastName)
    VALUES (:NEW.lnameID, :NEW.lastName);
    
    -- Insert into CUSTOMER_FNAMES association table
    INSERT INTO CUSTOMER_FNAMES(customerid, fnameID, starttime, endtime, notes)
    VALUES (:NEW.customerID, :NEW.fnameID, SYSTIMESTAMP, NULL, :NEW.notes);
    
    -- Insert into CUSTOMER_LNAMES association table
    INSERT INTO CUSTOMER_LNAMES(customerid, lnameID, starttime, endtime, notes)
    VALUES (:NEW.customerID, :NEW.lnameID, SYSTIMESTAMP, NULL, :NEW.notes); 
    
    -- Create an exception where insert isn't commited if an error occurs
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20000, 'An error occured during insert. Insert not committed.');
END;
/