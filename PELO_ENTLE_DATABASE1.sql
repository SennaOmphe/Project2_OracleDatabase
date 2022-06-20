
--------------------------------------------------------DROP---------------------------------------------------------------
drop table countries cascade constraints;
drop table departments cascade constraints;
drop table employees cascade constraints;
drop table jobs cascade constraints;
drop table regions cascade constraints;
drop table locations cascade constraints;
drop table customer cascade constraints;
drop table DELIVERY cascade constraints;
drop table ADMINISTRATION cascade constraints;
drop table BOOKING cascade constraints;
drop table CARD cascade constraints;
drop table CASH cascade constraints;
drop table CHEF cascade constraints;
drop table COLLECTION cascade constraints;
drop table CUSTOMER cascade constraints;
drop table DELIVER cascade constraints;
drop table DELIVERY cascade constraints;
drop table DESSERT cascade constraints;
drop table DRINKS cascade constraints;
drop table EMPLOYEE cascade constraints;
drop table FOOD cascade constraints;
drop table MENU cascade constraints;
drop table ONLINES cascade constraints;
drop table ORDERS cascade constraints;
drop table PAYMENT cascade constraints;

--------------------------------------------DROP SEQUENCE-----------------------------------------------------------------------
DROP SEQUENCE BOOKING_ID_VALUE;
DROP SEQUENCE CUSTOMER_ID_VALUE;
DROP SEQUENCE ORDER_ID_VALUE;
DROP SEQUENCE PAYMENT_ID_VALUE;
DROP SEQUENCE DELIVER_ID_VALUE;
DROP SEQUENCE PRODUCT_ID_VALUE;
DROP SEQUENCE EMP_ID_VALUE;

--------------------------------------------------------CREATE TABLES---------------------------------------------------------------
CREATE TABLE CUSTOMER(
    CUSTOMER_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CUSTOMER_FNAME VARCHAR2(50) NOT NULL,
    CUSTOMER_LNAME VARCHAR2(50) NOT NULL,
    USERNAME VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(100) NOT NULL,
    PHONE_NUM CHAR(10) NOT NULL,
    EMAIL VARCHAR2(50),
    ADDRESS VARCHAR2(100)
);

CREATE TABLE ORDERS(
    ORDER_ID NUMBER(5) PRIMARY KEY NOT NULL,
    CUSTOMER_ID NUMBER(4),
    CONSTRAINT FK_ORDER FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
    ORDER_DATE DATE NOT NULL,
    ORDER_STATUS NUMBER(1),
    TOTAL_PRICE NUMBER(19,2) NOT NULL
);

CREATE TABLE BOOKING(
    BOOKING_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CUSTOMER_ID NUMBER(4),
    CONSTRAINT FK_BOOKING FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
    BOOKING_DATE DATE NOT NULL,
    NUM_GUESTS NUMBER (5) NOT NULL,
    EVENT_TYPE VARCHAR2(50) NOT NULL,
    TOTAL_PRICE NUMBER(19,2) NOT NULL
);

--
CREATE TABLE MENU(
    PRODUCT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    BOOKING_ID NUMBER(4) NULL,
    CONSTRAINT FK_MENU1 FOREIGN KEY (BOOKING_ID) REFERENCES BOOKING (BOOKING_ID),
    ORDER_ID NUMBER(4) NULL,
    CONSTRAINT FK_MENU2 FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
    CATEGORY CHAR(1)
);
--
CREATE TABLE DRINKS(
    PRODUCT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_DRINKS FOREIGN KEY (PRODUCT_ID) REFERENCES MENU (PRODUCT_ID),
    DRINK_NAME VARCHAR2(20),
    DRINK_PRICE NUMBER(19,2),
    DRINK_QUANTITY NUMBER(3,2)
);

CREATE TABLE FOOD(
    PRODUCT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_FOOD FOREIGN KEY (PRODUCT_ID) REFERENCES MENU (PRODUCT_ID),
    FOOD_NAME VARCHAR2(20),
    FOOD_PRICE NUMBER(19,2),
    FOOD_QUANTITY NUMBER(3,2)
);

CREATE TABLE DESSERT(
    PRODUCT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_DESSERET FOREIGN KEY (PRODUCT_ID) REFERENCES MENU (PRODUCT_ID),
    DESSERT_NAME VARCHAR2(20),
    DESSERT_PRICE NUMBER(19,2),
    DESSERT_QUANTITY NUMBER(3,2)
);

CREATE TABLE PAYMENT(
    PAYMENT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    ORDER_ID NUMBER(5) NOT NULL,
    CONSTRAINT FK_PAYMENT FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
    PAYMENT_TYPE CHAR(1),
    TOTAL_AMOUNT NUMBER(19,2)
);

CREATE TABLE ONLINES(
    PAYMENT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_ONLINE FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT (PAYMENT_ID),
    BANK_NAME VARCHAR2(50),
    BRANCH VARCHAR2(50),
    CARD_NUMBER NUMBER(16),
    CVV NUMBER(3),
    EXP_DATE DATE
);

CREATE TABLE CASH(
    PAYMENT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_CASH FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT (PAYMENT_ID),
    CASH_OPTION NUMBER(1)
);

CREATE TABLE CARD(
    PAYMENT_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_CARD FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT (PAYMENT_ID),
    CARD_OPTION NUMBER(1)
);
--
CREATE TABLE DELIVERY(
    DELIVER_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CUSTOMER_ID NUMBER(4) NOT NULL,
    CONSTRAINT FK_DELIVERY FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
    DELIVERY_TYPE CHAR(1)
);

CREATE TABLE COLLECTION(
    DELIVER_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_COLLECTION FOREIGN KEY (DELIVER_ID) REFERENCES DELIVERY (DELIVER_ID),
    COLLECT_DATE DATE
);

CREATE TABLE DELIVER(
    DELIVER_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_DELIVER FOREIGN KEY (DELIVER_ID) REFERENCES DELIVERY (DELIVER_ID),
    DELIVERY_DATE DATE,
    DELIVERY_AMOUNT NUMBER(19,2)
);

CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER(4) PRIMARY KEY NOT NULL,
    PRODUCT_ID NUMBER(4),
    CONSTRAINT FK_EMPLOYEE FOREIGN KEY (PRODUCT_ID) REFERENCES MENU (PRODUCT_ID),
    ORDER_ID NUMBER(4),
    CONSTRAINT FK_EMPLOYEE2 FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
    EMP_USERNAME VARCHAR2(50),
    EMP_PASSWORD VARCHAR2(100),
    EMP_TYPE CHAR(1),
    SALARY NUMBER(19,2),
    SHIFT DATE
);
--

CREATE TABLE CHEF(
    EMP_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_CHEF FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID),
    HOURS NUMBER(2),
    CHEF_TYPE NUMBER(1)
);

CREATE TABLE ADMINISTRATION(
    EMP_ID NUMBER(4) PRIMARY KEY NOT NULL,
    CONSTRAINT FK_ADMIN FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID),
    ADMIN_TYPE NUMBER(1)
);

--------------------------------------------------------SEQUENCENCES---------------------------------------------------------------
CREATE SEQUENCE CUSTOMER_ID_VALUE
    start with 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 1000
    CYCLE;
--    
--
CREATE SEQUENCE ORDER_ID_VALUE
    start with 50
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    CYCLE;
    
CREATE SEQUENCE BOOKING_ID_VALUE
    start with 10
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 1000
    CYCLE;    

CREATE SEQUENCE PRODUCT_ID_VALUE
    start with 100
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE;

CREATE SEQUENCE PAYMENT_ID_VALUE
    start with 75
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    CYCLE;
    
CREATE SEQUENCE DELIVER_ID_VALUE
    start with 150
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 100000
    CYCLE; 
    
CREATE SEQUENCE EMP_ID_VALUE
    start with 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 1000
    CYCLE;   


--------------------------------------------------------INDEXES---------------------------------------------------------------
CREATE INDEX idx_CustomerNames
ON CUSTOMER (CUSTOMER_FNAME, CUSTOMER_LNAME, ADDRESS);

CREATE INDEX idx_EmpDetails
ON EMPLOYEE (EMP_USERNAME, EMP_TYPE, SHIFT);

CREATE INDEX idx_DRINKS
ON DRINKS (DRINK_NAME, DRINK_PRICE);

CREATE INDEX idx_FOOD
ON FOOD (FOOD_NAME, FOOD_PRICE);

CREATE INDEX idx_DESSERT
ON DESSERT (DESSERT_NAME, DESSERT_PRICE);

--------------------------------------------------DROPPED VIEW------------------------------------------------------------------
DROP VIEW CUSTOMER_COUNTNAMES;


------------------------------------------------------------VIEWS--------------------------------------------------------------------

CREATE VIEW CUSTOMER_DETAILS AS
SELECT CUSTOMER_ID,CUSTOMER_FNAME ,CUSTOMER_LNAME,USERNAME ,PHONE_NUM ,EMAIL ,ADDRESS  FROM CUSTOMER WHERE customer_fname = 'NTHABISENG' AND customer_lname = 'TLOU';



CREATE VIEW CUSTOMER_COUNTNAMES AS
SELECT COUNT(customer_fname) AS "NUMBER_OF_CUSTOMER" FROM CUSTOMER WHERE customer_fname = 'NEO';



CREATE VIEW ACTIVE_ORDERS AS
SELECT c.CUSTOMER_ID AS "CUSTOMER ID", c.CUSTOMER_FNAME AS "CUSTOMER NAME", c.CUSTOMER_LNAME AS "CUSTOMER SURNAME", o.ORDER_STATUS AS "ORDER STATUS"
FROM CUSTOMER c, ORDERS o WHERE ORDER_STATUS = 1 AND c.CUSTOMER_ID = o.CUSTOMER_ID;



CREATE VIEW NUMBER_GUESTS AS
SELECT c.CUSTOMER_FNAME AS "CUSTOMER NAME", c.CUSTOMER_LNAME AS "CUSTOMER SURNAME", c.ADDRESS AS "CUSTOMER ADDRESS", b. NUM_GUESTS AS "NUMBER OF GUESTS", b.EVENT_TYPE AS "EVENT TYPE"
FROM CUSTOMER c, BOOKING b
WHERE NUM_GUESTS >= 10 AND c.CUSTOMER_ID = b.CUSTOMER_ID;


select * from NUMBER_GUESTS;
------------------------------------------------------------ADD DATA--------------------------------------------------------------
-----------------------------------------------------------ADD INTO CUSTOMER--------------------------------------------------------------
INSERT INTO EMPLOYEE (EMP_ID,CUSTOMER_ID, EMP_USERNAME, EMP_PASSWORD, EMP_TYPE, SALARY, SHIFT)
VALUES (ORDER_ID_VALUE.nextval, CUSTOMER_ID, EMP_ID, TO_DATE('24/05/2022 12:00:00', 'dd/mm/yyyy hh:mi:ss'),1,1500.00);

INSERT INTO EMPLOYEE (EMP_ID,product_id, EMP_USERNAME,EMP_PASSWORD, EMP_TYPE, SALARY, SHIFT)
VALUES (EMP_ID_VALUE.nextval,PRODUCT_ID_VALUE.nextval,"John","#######",1,10000.56, TO_DATE('24/05/2022 12:00:00', 'dd/mm/yyyy hh:mi:ss'));

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME,USERNAME,PASSWORD,PHONE_NUM,EMAIL,ADDRESS)
VALUES (CUSTOMER_ID_VALUE.nextval,'Thando','Wenn','THANN','#########','0785401615','THANDO@GMAIL.COM','21st Street Pretoria');

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME,USERNAME,PASSWORD,PHONE_NUM,EMAIL,ADDRESS)
VALUES (CUSTOMER_ID_VALUE.nextval,'Lindi','Nkosi','LN','#########','0624875852','LUNDI@GMAIL.COM','1st Street Mangau');

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME,USERNAME,PASSWORD,PHONE_NUM,EMAIL,ADDRESS)
VALUES (CUSTOMER_ID_VALUE.nextval,'Neo','Babedi','NeoP','#########','0785401644','Neo@GMAIL.COM','21st Street Taung');

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME,USERNAME,PASSWORD,PHONE_NUM,EMAIL,ADDRESS)
VALUES (CUSTOMER_ID_VALUE.nextval,'Lebo','Paai','LPaai','#########','0844701615','Paai@GMAIL.COM','nwu Street 1999 Pretoria');

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME,USERNAME,PASSWORD,PHONE_NUM,EMAIL,ADDRESS)
VALUES (CUSTOMER_ID_VALUE.nextval,'JOHN','MOORE','JMOORE','##########','0844987615','MOORE@GMAIL.COM','KZN Street 1999 Pretoria');

---------------------------------------------------INSERT BOOKING------------------------------------------------------------------------------
INSERT INTO BOOKING(BOOKING_ID, CUSTOMER_ID, BOOKING_DATE, NUM_GUESTS, EVENT_TYPE, TOTAL_PRICE)
VALUES (BOOKING_ID_VALUE.nextval,1,TO_DATE('24-05-2022 12:00:00', 'dd/mm/yyyy hh:mi:ss' ), 50, 'WEDDING', 15000.46);

INSERT INTO BOOKING(BOOKING_ID, CUSTOMER_ID, BOOKING_DATE, NUM_GUESTS, EVENT_TYPE, TOTAL_PRICE)
VALUES (BOOKING_ID_VALUE.nextval,2, TO_DATE('30-07-2022 14:45:00', 'dd/mm/yyyy hh24:mi:ss' ), 100, 'FUNERAL', 150);

INSERT INTO BOOKING(BOOKING_ID, CUSTOMER_ID, BOOKING_DATE, NUM_GUESTS, EVENT_TYPE, TOTAL_PRICE)
VALUES (BOOKING_ID_VALUE.nextval,3, TO_DATE('30-08-2022 18:45:00', 'dd/mm/yyyy hh24:mi:ss' ), 5, 'BABY SH0WER', 5000);

INSERT INTO BOOKING(BOOKING_ID, CUSTOMER_ID, BOOKING_DATE, NUM_GUESTS, EVENT_TYPE, TOTAL_PRICE)
VALUES (BOOKING_ID_VALUE.nextval,1, TO_DATE('15-08-2022 18:45:00', 'dd/mm/yyyy hh24:mi:ss' ), 2, 'DINNER FOR 2', 500);

------------------------------------------------------INSERT MENU---------------------------------------------------------------------------------
INSERT INTO MENU(PRODUCT_ID,BOOKING_ID,ORDER_ID, CATEGORY)
VALUES (PRODUCT_ID_VALUE.nextval ,NULL, 52, 'F');


INSERT INTO MENU(PRODUCT_ID,BOOKING_ID,ORDER_ID,CATEGORY)
VALUES (PRODUCT_ID_VALUE.nextval ,NULL,51, 'F');

INSERT INTO MENU(PRODUCT_ID,BOOKING_ID,ORDER_ID,CATEGORY)
VALUES (PRODUCT_ID_VALUE.nextval ,10,NULL, 'D');

INSERT INTO MENU(PRODUCT_ID,BOOKING_ID,ORDER_ID,CATEGORY)
VALUES (PRODUCT_ID_VALUE.nextval ,11,NULL, 'F');


------------------------------------------------------INSERT ORDER---------------------------------------------------------------------------------
INSERT INTO ORDERS(ORDER_ID,CUSTOMER_ID,ORDER_DATE,ORDER_STATUS,TOTAL_PRICE)
VALUES (ORDER_ID_VALUE.nextval ,4,TO_DATE('24-08-2022 18:00:00', 'dd/mm/yyyy hh24:mi:ss'),1,35.00);

INSERT INTO ORDERS(ORDER_ID,CUSTOMER_ID,ORDER_DATE,ORDER_STATUS,TOTAL_PRICE)
VALUES (ORDER_ID_VALUE.nextval ,5,TO_DATE('15-06-2022 12:00:00', 'dd/mm/yyyy hh24:mi:ss'),0,3500.10);


---------------------------------------INSERT DATA DRINKS------------------------------------------------------------
INSERT INTO DRINKS (PRODUCT_ID, DRINK_NAME, DRINK_PRICE, DRINK_QUANTITY)
VALUES (101, 'GINGER BEER', 25.00, 2);
-----------------------------------------INSERT FOOD-----------------------------------------------------------------

INSERT INTO FOOD (PRODUCT_ID, FOOD_NAME, FOOD_PRICE, FOOD_QUANTITY)
VALUES (100, 'MOGODU', 300.00, 8);

INSERT INTO FOOD (PRODUCT_ID, FOOD_NAME, FOOD_PRICE, FOOD_QUANTITY)
VALUES (102, 'MOGODU', 550.00, 9);

INSERT INTO DESSERT (PRODUCT_ID, DESSERT_NAME, FOOD_PRICE, FOOD_QUANTITY)
VALUES (102, 'MOGODU', 550.00, 9);


----------------------------------------------------CHECK CONSTRAINTS----------------------------------------------------------------

ALTER TABLE MENU ADD CONSTRAINT "CATEGORY_CHECK_F_OR_D_T" CHECK (CATEGORY IN('F','D','T')) ENABLE;
ALTER TABLE EMPLOYEE ADD CONSTRAINT "EMPLOY_CHECK_C_OR_A" CHECK (EMP_TYPE IN('C','A')) ENABLE;
ALTER TABLE DELIVERY ADD CONSTRAINT "DELIVERY_CHECK_D_OR_C" CHECK (DELIVERY_TYPE IN('D','C')) ENABLE;
ALTER TABLE PAYMENT ADD CONSTRAINT "PAYMENT_CHECK_O_OR_C_S" CHECK (PAYMENT_TYPE IN('O','C','S')) ENABLE;


----------------------------------------------INSERT DELIVERY------------------------------------------------------------

INSERT INTO DELIVERY (deliver_id,customer_id,delivery_type)
VALUES (DELIVER_ID_VALUE.nextval,4,'C');

INSERT INTO DELIVERY (deliver_id,customer_id,delivery_type)
VALUES (DELIVER_ID_VALUE.nextval,5,'D');


INSERT INTO deliver(deliver_id,DELIVERY_DATE,DELIVERY_AMOUNT)
VALUES (151,TO_DATE('24-08-2022 18:00:00', 'dd/mm/yyyy hh24:mi:ss'),49.99);

INSERT INTO COLLECTION(deliver_id,collect_date)
VALUES (150,TO_DATE('24-08-2022 13:30:00', 'dd/mm/yyyy hh24:mi:ss'));


----------------------------------------------INSERT EMPLOYEE------------------------------------------------------------

INSERT INTO EMPLOYEE (EMP_ID,order_id,PRODUCT_ID,EMP_USERNAME,EMP_PASSWORD,EMP_TYPE,SALARY,SHIFT)
VALUES (EMP_ID_VALUE.nextval,51,100,'KARABO','######','A',14999.999,TO_DATE('24-08-2022 13:30:00', 'dd/mm/yyyy hh24:mi:ss'));

INSERT INTO administration (EMP_ID,admin_type)
VALUES (1,1);

INSERT INTO EMPLOYEE (EMP_ID,order_id,PRODUCT_ID,EMP_USERNAME,EMP_PASSWORD,EMP_TYPE,SALARY,SHIFT)
VALUES (EMP_ID_VALUE.nextval,52,100,'KGOMOTSO','####','C',15999.999,TO_DATE('01-08-2022 07:30:00', 'dd/mm/yyyy hh24:mi:ss'));

INSERT INTO CHEF (EMP_ID,chef_type)
VALUES (2,1);



------------------------------------------------------QUERIES----------------------------------------------------------------



---------------------------------------------STATEMENT1------LIKE--AND---OR--------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(customer_fname) AS "NUMBER_OF_CUSTOMER" FROM CUSTOMER WHERE customer_fname LIKE 'L%';
SELECT customer_fname AS "CUSTOMER" FROM CUSTOMER WHERE customer_fname LIKE 'L%';
SELECT * FROM BOOKING WHERE num_guests >=10 AND event_type = 'FUNERAL';
SELECT * FROM BOOKING WHERE num_guests >=10 OR event_type = 'FUNERAL';

----------------------------------------------------SORTING-------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
                                ---Retrieve
SELECT * FROM CUSTOMER ORDER BY customer_lname ASC;
SELECT * FROM CUSTOMER ORDER BY customer_fname DESC;
SELECT * FROM CUSTOMER ORDER BY phone_num ASC;
SELECT CATEGORY FROM MENU ORDER BY 1;

-----------------------------------------------------JOIN---------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

SELECT c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, c.ADDRESS, b. NUM_GUESTS, b.EVENT_TYPE, b.booking_date
FROM CUSTOMER c JOIN BOOKING b ON c.CUSTOMER_ID = b.CUSTOMER_ID
WHERE NUM_GUESTS = 100;


SELECT c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, c.ADDRESS, b. NUM_GUESTS, b.EVENT_TYPE, b.booking_date, m.CATEGORY
FROM CUSTOMER c JOIN BOOKING b 
ON c.CUSTOMER_ID = b.CUSTOMER_ID JOIN
MENU m
ON b.booking_id = m.booking_id
WHERE NUM_GUESTS = 100;


---------------------------------------limitation---------------------------------------------------
-----------------------------------------------------------------------------------------------------

----CUSTOMERS WITH ACTIVE ORDERS--------
SELECT c.CUSTOMER_ID, c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, o.ORDER_STATUS
FROM CUSTOMER c, ORDERS o WHERE ORDER_STATUS = 1 AND c.CUSTOMER_ID = o.CUSTOMER_ID;


SELECT c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, c.ADDRESS, b. NUM_GUESTS, b.EVENT_TYPE, b.booking_date, m.CATEGORY
FROM CUSTOMER c JOIN BOOKING b 
ON c.CUSTOMER_ID = b.CUSTOMER_ID JOIN
MENU m
ON b.booking_id = m.booking_id AND c.customer_id = b.customer_id
WHERE NUM_GUESTS > 5 ;




                       ------------SHOW 1 ROWS ONLY--------------------------
select * from (select * from CUSTOMER order by PHONE_NUM) where rownum = 1;
                        ------------SHOW 3 ROWS ONLY--------------------------
select * from (select * from CUSTOMER order by PHONE_NUM) where rownum <= 3;




-----------------------------------------------HAVING AND GROUB BY----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
SELECT CATEGORY, COUNT(CATEGORY)AS COUNT FROM MENU order BY CATEGORY;

SELECT * FROM (SELECT CATEGORY, COUNT(CATEGORY)AS COUNT FROM MENU GROUP BY CATEGORY) WHERE COUNT <=3;

SELECT CATEGORY, COUNT(CATEGORY)AS COUNT FROM MENU GROUP BY CATEGORY HAVING COUNT(CATEGORY) >2;

SELECT * FROM (SELECT CATEGORY, COUNT(CATEGORY)AS COUNT FROM MENU GROUP BY CATEGORY) WHERE COUNT =3;






---------------------------------------------------AGGREGATE FUNCTION-----------------------------------------------
--------------------SUM----------------------------------
SELECT SUM(FOOD_PRICE * FOOD_QUANTITY) FROM FOOD;
SELECT PRODUCT_ID,FOOD_NAME,FOOD_PRICE,FOOD_QUANTITY,(SELECT SUM(FOOD_PRICE * FOOD_QUANTITY) FROM FOOD) AS "TOTAL_SUM" FROM FOOD;

--------------------MIN----------------------------------
SELECT SUM(DRINK_PRICE * DRINK_QUANTITY)AS "DRINK MIN PRICE" FROM DRINKS;
SELECT PRODUCT_ID,DRINK_NAME,DRINK_PRICE,DRINK_QUANTITY,(SELECT MIN(DRINK_PRICE * DRINK_QUANTITY) FROM DRINKS) AS "TOTAL_MIN" FROM DRINKS;

--------------------MAX----------------------------------
SELECT FOOD_PRICE * FOOD_QUANTITY AS "FOOD TOTAL PRICES" FROM FOOD;
SELECT MAX(FOOD_PRICE * FOOD_QUANTITY)AS "FOOD MAX PRICE" FROM FOOD;
SELECT PRODUCT_ID,FOOD_NAME,FOOD_PRICE,FOOD_QUANTITY,(SELECT MAX(FOOD_PRICE * FOOD_QUANTITY) FROM FOOD) AS "MAX VALU" FROM FOOD;






----------------------------------------------DATE FUNCTIONS------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
SELECT BOOKING_ID, booking_date, event_type, num_guests, total_price FROM BOOKING WHERE TO_CHAR(booking_date) = '3';
SELECT CAST(booking_date AS TIMESTAMP)"TIME" FROM BOOKING;
SELECT CAST(booking_date AS TIMESTAMP)"TIME" FROM BOOKING WHERE rownum = 1;

SELECT booking_id,customer_id,num_guests,CAST(booking_date AS TIMESTAMP)"TIME" FROM BOOKING WHERE rownum >= 1 and num_guests>=100;







----------------------------------------------VARIABLES AND CHARACTER FUNCTION ---------------------------------------------------------------
------FIRST LETTER AS CAPITAL---------
SELECT INITCAP(customer_fname),INITCAP(customer_lname),address FROM CUSTOMER;
------CAPITAL LETTERS---------
SELECT UPPER(customer_fname),UPPER(customer_lname),address FROM CUSTOMER;
------LOWER LETTERS---------
SELECT LOWER(customer_fname),LOWER(customer_lname),address FROM CUSTOMER;

SELECT c.CUSTOMER_ID, UPPER(c.CUSTOMER_FNAME), INITCAP(c.CUSTOMER_LNAME), o.ORDER_STATUS
FROM CUSTOMER c, ORDERS o WHERE ORDER_STATUS = 1 AND c.CUSTOMER_ID = o.CUSTOMER_ID;

------CONCAT FNAME AND LMANE---------
SELECT customer_id,(CUSTOMER_FNAME||CUSTOMER_LNAME) FROM CUSTOMER;
SELECT customer_id,CONCAT(CUSTOMER_FNAME,CUSTOMER_LNAME) FROM CUSTOMER;







----------------------------------------------ROUND ---------------------------------------------------------------
SELECT booking_id,customer_id,num_guests,event_type,booking_date,ROUND(TOTAL_PRICE,1) FROM BOOKING;


SELECT c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, c.ADDRESS, b. NUM_GUESTS, b.EVENT_TYPE, b.booking_date, Round(b.total_price,1)
FROM CUSTOMER c JOIN BOOKING b ON c.CUSTOMER_ID = b.CUSTOMER_ID
WHERE NUM_GUESTS = 100;

SELECT c.emp_username, c.emp_type, c.shift, ROUND(c.salary), b.order_date, b.order_status, b.customer_id
FROM EMPLOYEE c JOIN ORDERS b ON c.order_id = b.order_id;

SELECT c.CUSTOMER_FNAME, c.CUSTOMER_LNAME, c.ADDRESS, b.order_date, b.order_status, Round(b.total_price,2)
FROM CUSTOMER c JOIN ORDERS b ON c.CUSTOMER_ID = b.CUSTOMER_ID
WHERE total_price > 100;


------------------------------------------------------SUB QUERIES--------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------SELECT 1ROW AFTER ORDER---------------
select * from (select * from CUSTOMER order by PHONE_NUM) where rownum = 1;

----------------------------SHOW AVARAGE---------------
SELECT ORDER_ID,CUSTOMER_ID,ORDER_DATE,ORDER_STATUS,TOTAL_PRICE, (SELECT AVG(TOTAL_PRICE) FROM ORDERS) AS AVARAGE_PRICE FROM ORDERS;
SELECT * FROM orders WHERE total_price < (select AVG(TOTAL_PRICE) FROM ORDERS);


-----------------------SELECT ALL FROM CUSTOMER TABLE THAT CROSSPOND TO THE CUSTOMER ID IN THE ORDER TABLE-----------------------------
SELECT * FROM CUSTOMER WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS);

-----------------------RETRIEVE MENUES THAT CROSPONDE TO THE BOOKING TABLE WHERE NUMBER OF GUESTS IS LESS THAN 200---------------------
SELECT * FROM MENU WHERE booking_id IN (SELECT booking_id FROM BOOKING WHERE NUM_GUESTS < 200);




DELETE FROM CUSTOMER;
DELETE FROM BOOKING;
DELETE FROM ORDERS;
SELECT * FROM CUSTOMER;
SELECT * FROM BOOKING ORDER BY BOOKING_ID;
SELECT * FROM MENU;

SELECT * FROM DRINKS;
SELECT * FROM DELIVERY;
SELECT * FROM DELIVER;
SELECT * FROM collection;
SELECT * FROM EMPLOYEE;
SELECT * FROM orders;

DESC EMPLOYEE;
DESC ADMINISTRATION;

