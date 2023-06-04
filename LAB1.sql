BEGIN TRANSACTION;

Create Database if not exists 'order-directory';
use 'order-directory'; 

/* Create a table called Supplier */
CREATE TABLE Supplier(SUPP_ID int, SUPP_NAME varchar ,SUPP_CITY varchar ,SUPP_PHONE varchar );

/* Create few records in Supplier table */
INSERT INTO Supplier VALUES(1,'Rajesh Retails','Delhi','1234567890');
INSERT INTO Supplier VALUES(2,'Appario Ltd', 'Mumbai', '2589631470');
INSERT INTO Supplier VALUES(3,'Knome products', 'Banglore', '9785462315');
INSERT INTO Supplier VALUES(4,'Bansal Retails', 'Kochi','8975463285');
INSERT INTO Supplier VALUES(5,'Mittal Ltd', 'Lucknow','7898456532');

/* Display all the records from the Supplier table */
SELECT * FROM Supplier;


/* Create a table called Customer */
CREATE TABLE Customer(CUS_ID int NOT NULL,CUS_NAME varchar(20) NULL DEFAULT NULL,CUS_PHONE varchar,CUS_CITY varchar,CUS_GENDER CHAR, PRIMARY KEY (`CUS_ID`));

/* Create few records in Customer table */
INSERT INTO Customer VALUES(1,'AAKASH','9999999999','DELHI','M');
INSERT INTO Customer VALUES(2,'AMAN','9785463215','NOIDA','M');
INSERT INTO Customer VALUES(3,'NEHA','9999999999','MUMBAI','F');
INSERT INTO Customer VALUES(4,'MEGHA','9994562399','KOLKATA','F');
INSERT INTO Customer VALUES(5,'PULKIT','7895999999','LUCKNOW','M');


/* Display all the records from the Customer table */
SELECT * FROM Customer;

CREATE TABLE Category(CAT_ID int NOT NULL,CAT_NAME varchar(20) NULL DEFAULT NULL, PRIMARY KEY (`CAT_ID`));

INSERT INTO Category Values(1,'BOOKS');
INSERT INTO Category Values(2,'GAMES');
INSERT INTO Category Values(3,'GROCERIES');
INSERT INTO Category Values(4,'ELECTRONICS');
INSERT INTO Category Values(5,'CLOTHES');

select *from Category;

Create table Product(PRO_ID INT NOT NULL,PRO_NAME varchar(20) NULL DEFAULT NULL,PRO_DESC varchar(60) NULL DEFAULT NULL,CAT_ID int,  PRIMARY KEY (`PRO_ID`),  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`));

Insert into Product Values (1,'GTA V','DFJDJFDJFDJFDJFJF',2);
Insert into Product Values (2,'TSHIRT','DFDFJDFJDKFD',5);
Insert into Product Values (3,'ROG LAPTOP','DFNTTNTNTERND',4);
Insert into Product Values (4,'OATS','REURENTBTOTH',3);
Insert into Product Values (5,'HARRY POTTER','NBEMCTHTJTH',1);

select *from Product;



Create table ProductDetails(PROD_ID int,PRO_ID int,SUPP_ID int,PRICE int,  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
);



Insert into ProductDetails values(1,1,2,1500);
Insert into ProductDetails values(2,3,5,30000);
Insert into ProductDetails values(3,5,1,3000);
Insert into ProductDetails values(4,2,3,2500);
Insert into ProductDetails values(5,4,1,1000);

select *from ProductDetails;



Create table Orders(ORD_ID int,ORD_AMOUNT int,ORD_DATE date,CUS_ID int,PROD_ID int,  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
);

Insert into Orders values(20,1500,'2021-10-12',3,5);
Insert into Orders values(25,30500,'2021-09-16',5,2);
Insert into Orders values(26,2000,'2021-10-05',1,1);
Insert into Orders values(30,3500,'2021-08-16',4,3);
Insert into Orders values(50,2000,'2021-10-06',2,1);

select *from Orders;




Create Table Rating(RAT_ID int,CUS_ID int ,SUPP_ID int,RAT_RATSTARS int,  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
);

Insert into Rating values(1,2,2,4);
Insert into Rating values(2,3,4,3);
Insert into Rating values(3,5,1,5);
Insert into Rating values(4,1,3,2);
Insert into Rating values(5,4,5,4);

select *From  Rating;

//3)Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000

select Cust.CUS_NAME,Cust.CUS_Gender, Count(Cust.CUS_id) from Customer cust 
inner join Orders Ord on Ord.CUS_ID=Cust.CUS_ID where Ord.ORD_AMOUNT>=3000 group by 
Cust.CUS_GENDER;

//4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2

select Ord.ORD_ID,Prod.PRO_NAME,Ord.ORD_Amount,Ord_DATE from Orders Ord 
inner join Customer Cust on Cust.CUS_ID=Ord.CUS_ID 
inner join ProductDetails PD on PD.PROD_ID=Ord.PROD_ID
inner join Product Prod on Prod.PRO_ID=PD.PRO_ID
where Cust.CUS_ID=2;

//5)	Display the Supplier details who can supply more than one product.
select Sup.SUPP_ID,Sup.SUPP_NAME,Sup.SUPP_CITY,Sup.SUPP_PHONE,PD.PRO_ID From 
Supplier Sup inner join Product_Details PD on PD.SUPP_ID=Sup.SUPP_ID group by PD.SUPP_ID having count(PD.PRO_ID)>1

//6)	Find the category of the product whose order amount is minimum.

select cat.*,Prod.PRO_NAME,Ord.ORD_AMOUNT from 
Category cat inner join Product Prod on Prod.CAT_ID = Cat.CAT_ID
inner join ProductDetails PD on PD.PRO_ID=Prod.PRO_ID
inner join Orders Ord on Ord.PROD_ID = PD.PROD_ID having MIN(Ord.ORD_AMOUNT);

//7

select product.pro_id,product.pro_name from Orders inner join productdetails on productdetails.prod_id=Orders.prod_id inner join product on product.pro_id=productdetails.pro_id where Orders.ord_date>"2021-10-05";

//8

//9
select customer.cus_name ,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';


COMMIT;