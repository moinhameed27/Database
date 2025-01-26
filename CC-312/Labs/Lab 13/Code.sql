----------------------------------- Task 1 -----------------------------------
-- Part I (Creation and Insertion)
-- Customer Table
create table Customers (
CustomerID int primary key,
CustomerName varchar(100),
Email varchar(100)
);

-- Products Table
create table Products (
ProductID int primary key,
ProductName varchar(100),
Stock int not null check (Stock >= 0),
Price decimal(10,2) not null
);

-- Orders Table
create table Orders (
OrderID int primary key auto_increment,
CustomerID int,
ProductID int,
Quantity int not null,
OrderDate timestamp default current_timestamp,
foreign key (CustomerID) references Customers(CustomerID),
foreign key (ProductID) references Products(ProductID)
);

-- Insert Customers
insert into Customers (CustomerID, CustomerName, Email) values
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com');

-- Insert Products
insert into Products (ProductID, ProductName, Stock, Price) values
(1, 'Laptop', 10, 1000.00),
(2, 'Smartphone', 15, 700.00),
(3, 'Headphones', 50, 50.00);

-- Verify Data
select * from Customers;
select * from Products;


-- Part II (Transaction Management Tasks)
/* Scenario 1: Placing an Order and Simulate placing two orders */

start transaction;

-- Reduce stock
update Products set Stock = Stock - 5 where ProductID = 1;

-- Savepoint
savepoint AfterStockUpdate;

/* Scenario 2: Update an Order
Update Alice's order from 5 Laptops to 8 Laptops. Rollback if the total price exceeds 5000. */

start transaction;

-- Attempt to reduce stock
update Products set Stock = Stock - 12 where ProductID = 1;

-- Check and rollback
rollback;

-- Verify no changes were made
SELECT * FROM Products;
SELECT * FROM Orders;

/* Scenario 3: Cancel an Order
Cancel Alice's order for Laptops and restore the stock. */

start transaction;

-- Update order quantity
update Orders set Quantity = 8 where OrderID = 1;

-- Adjust stock
update Products set Stock = Stock - (8 - 5) where ProductID = 1;

-- Savepoint before committing
savepoint BeforeCommit;

-- Calculate total price
select (8 * 1000) as TotalPrice;

/* Scenario 4: Place Multiple Orders
Data for the Scenario:
Customer Charlie places the following orders:
1. 30 Headphones.
2. 10 Smartphones. */

start transaction;
-- Order 1: Headphones
insert into Orders (CustomerID, ProductID, Quantity) values (3, 3, 30);
update Products set Stock = Stock - 30 where ProductID = 3;

-- Savepoint after first order
savepoint AfterFirstOrder;

-- Order 2: Smartphones
insert into Orders (CustomerID, ProductID, Quantity) values (3, 2, 10);
update Products set Stock = Stock - 10 where ProductID = 2;

-- Commit the transaction
commit;

-- Verify the changes
select * from Products;
select * from Orders;


-- Part III (Perform Queries on the Database)
/* 1. 1. Display Complete Details of All Transactions. */
select O.OrderID, C.CustomerName, P.ProductName, O.Quantity, P.Price,
(O.Quantity * P.Price) as TotalPrice, O.OrderDate
from Orders as O
join Customers as C on O.CustomerID = C.CustomerID
join Products as P on O.ProductID = P.ProductID;

/* 2. Show Updated Stock Levels. */
select ProductName, Stock from Products;

/* 3. Retrieve All Orders Placed by Charlie. */
select O.OrderID, P.ProductName, O.Quantity, (O.Quantity * P.Price) AS TotalPrice
from Orders as O
join Products as P on O.ProductID = P.ProductID
where O.CustomerID = 3;

/* 4. Display Total Quantity Ordered for Each Product. */
select P.ProductName, sum(O.Quantity) as TotalOrdered
from Orders as O
join Products as P on O.ProductID = P.ProductID
group by P.ProductName;

/* 5. Verify Data Consistency After Rollbacks. */
rollback;
select * from Products;
select * from Orders;