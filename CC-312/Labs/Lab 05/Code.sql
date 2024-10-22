----------------------------------- Task 1 -----------------------------------
/* 1. Create a database named ATM_USERS_DB. */
create database ATM_USERS_DB;
use ATM_USERS_DB;

/* Create Table User
Table Name : User
* Col Name
* Data Type
* constraints
1. UserID
   Int
   Primary Key
2. Name
   VARCHAR(20)
   Not Null
3. PhoneNum
   VARCHAR(15)
   Not Null
4. City
   VARCHAR(20)
   Not Null
*/

create table user (
	userId int primary key,
    name varchar(20) not null,
    phoneNum varchar(15) not null,
    city varchar(20) not null
);

/* Create table CardType 
Table Name : CardType
* Col Name
* Data Type
* constraints
1. CardTypeID
   Int
   Primary Key
2. Name
   VARCHAR(15)

3. Description
   VARCHAR(40)
   Not Null
*/

create table cardType (
	cardTypeId int primary key,
    name varchar(15),
    description varchar(40) not null
);

/* Create Table Card
Table Name : Card
* Col Name
* Data Type
* constraints
1. CardNum
   VARCHAR(20)
   Primary key
2. CardTypeID
   Int
   Foreign Key referencing CardType(CardTypeID)
3. PIN
   VARCHAR(4)
   Not Null
4. ExpireDate
   DATE
   Not Null
5. Balance
   Float
   Not Null
*/

create table card (
	cardNum varchar(20) primary key,
    cardTypeId int not null,
    pin varchar(4) not null,
    expireDate date not null,
    balance float not null,
    constraint fk_card_type_id foreign key (cardTypeId) references cardType(cardTypeId)
);

/* Create Table UserCard
Table Name : UserCard
* Col Name
* Data Type
* constraints
1. UserID
   Int
   Foreign key referencing User(UserID)
2. CardNum
   VARCHAR(20)
   Foreign Key referencing Card(CardNum), Primary key
*/

create table userCard (
	userId int,
	cardNum varchar(20) primary key,
	constraint fk_user_id foreign key (userId) references user(userId),
	constraint fk_card_num foreign key (cardNum) references card(cardNum)
);

/* Create Table Transaction
Table Name : Transaction
* Col Name
* Data Type
* constraints
1. TransID
   Int
   Auto_Increment, Primary Key
2. TransDate
   DATE
   Not Null
3. amount
   Int
   Not null
4. CardNum
   VARCHAR(20)
   Foreign Key referencing Card(CardNum)
*/

create table transaction (
	transId int auto_increment primary key,
	transDate date not null,
    amount int not null,
    cardNum varchar(20),
	constraint fk_card_num_T foreign key (cardNum) references card(cardNum)
);

/* 2. Insert records into the tables with the following data: */
/* i) User
UserID	Name	PhoneNum	City
   1	Ali    03036067000 Narowal
   2   Ahmad   03036047000 Lahore
   3   Aqeel   03036063000 Karachi
   4   Usman   03036062000 Sialkot
   5   Hafeez  03036061000 Lahore
*/
insert into user values
(1, "Ali", "03036067000", "Narowal"),
(2, "Ahmad", "03036047000", "Lahore"),
(3, "Aqeel", "03036063000", "Karachi"),
(4, "Usman", "03036062000", "Sialkot"),
(5, "Hafeez", "03036061000", "Lahore");

/* ii) CardType
CardTypeID   Name	 Description
     1 		Debit  Spend Now, Pay Now
	 2		Credit Spend Now, Pay Later
*/
insert into cardType values
(1, "Debit", "Spend Now, Pay Now"),
(2, "Credit", "Spend Now, Pay Later");


/* iii) Card
CardNum		CardTypeID		PIN		ExpireDate		Balance
 1234			1		   1770     2022-07-01	  	43025.31
 1235			1		   9234     2020-03-02		14425.62
 1236			1		   1234		2019-02-06		34325.52
 1237			2		   1200		2021-02-05		24325.30
 1238			2		   9004		2020-09-02		34025.12
*/
insert into card values
("1234", 1, "1770", "2022-07-01", 43025.31),
("1235", 1, "9234", "2020-03-02", 14425.62),
("1236", 1, "1234", "2019-02-06", 34325.52),
("1237", 2, "1200", "2021-02-05", 24325.30),
("1238", 2, "9004", "2020-09-02", 34025.12);

/* iv) UserCard
UserID		CardNum
  1			 1234
  1			 1235
  2			 1236
  3			 1238
  4			 1237
*/
insert into userCard values
(1, "1234"),
(1, "1235"),
(2, "1236"),
(3, "1238"),
(4, "1237");

/* v) Transaction
TransDate		CardNum		Amount
2017-02-02		  1234		 500
2018-02-03		  1235		 3000
2020-01-06		  1236		 2500
2016-09-09		  1238		 2000
2020-02-10		  1234 		 6000
*/
insert into transaction (transDate, amount, cardNum) values 
("2017-02-02", 500, "1234"),
("2018-02-03", 3000, "1235"),
("2020-01-06", 2500, "1236"),
("2016-09-09", 2000, "1238"),	
("2020-02-10", 6000, "1234");


----------------------------------- Task 2 -----------------------------------
/* 1. Show the details of users along with their card numbers and card type (only for users who have cards). */
select U.userId, U.name, U.phoneNum, U.city, C.cardNum, CT.name 
from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
join cardType as CT on CT.cardTypeId = C.cardTypeId;

/* 2. Show all cards and their owners, if they exist (include cards even if they don’t belong to any user). */
select C.cardNum, C.expireDate, C.cardTypeId, U.name as ownerName
from card as C
left join userCard as UC on C.cardNum = UC.cardNum
join user as U on U.userId = UC.userId;

/* 3. Show users and their card details where the card has expired.(expire date < CURRENT_DATE) */
select U.userId, U.name, C.cardNum, C.expireDate
from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
where current_date > expireDate;

/* 4. Show transaction details for cards of type "Credit". */
select * from transaction as T 
join card as C on T.cardNum = C.cardNum
where C.cardTypeId = 2;

select T.transId, T.transDate, T.amount, T.cardNum
from transaction as T
join card as C on T.cardNum = C.cardNum
join cardType as CT on C.cardTypeId = CT.cardTypeId
where CT.name = "Credit";

/* 5. Write a query to display the user ID, name, city, card type, card expiration date, and balance for users 
   who have cards expiring after January 1, 2020. */
select U.userId, U.name, U.city, CT.name, C.expireDate, C.balance
from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
join cardType as CT on C.cardTypeId = CT.cardTypeId
where C.expireDate > "2020-01-01";

/* 6. Display all the details of Emp who is not assigned to any department. */
select * from EMP where deptno is null;

select * from EMP where deptno not in (select deptno from EMP);

select E.empno , E.ename , E.deptno , E.job
from EMP as E
left join DEPT as D on E.deptNo = D.deptNo
where D.deptNO is null;


----------------------------------- Task 3 -----------------------------------
/* 1. Retrieve the details of the users  who do not own any card. */
select userId, name from user where name not in 
(select name from user as U join userCard as UC on U.userId = UC.userId);

select U.userId, U.name from user as U
left join userCard as UC on U.userId = UC.userId
where UC.userId is null;

/* 2. Show those card pairs which are expiring in the same year. */
select C1.cardNum, C1.expireDate from card as C1
join card as C2 on year(C1.expireDate) = year(C2.expireDate)
where C1.cardNum != C2.cardNum;

/* 3. Show those user pairs whose names’ first characters are the same. */
select distinct U1.name from user as U1
join user as U2 on substr(U1.name, 1, 1) = substr(U2.name, 1, 1)
where U1.name != U2.name;

/* 4. Find the cards that have no transactions associated with them. Display the card number and card owner’s name. */
select C.cardNum, U.name from card as C 
join userCard as UC, user as U
where C.cardNum = UC.cardNum and U.userId = UC.userId and C.cardNum not in 
(select C.cardNum from card as C join transaction as T on C.cardNum = T.cardNum);

select U.name, UC.cardNum from user as U
join userCard as UC on U.userId = UC.userId
left join transaction as T on UC.cardNum = T.cardNum
where T.cardNum is null;

/*
Note: Update the database using this query before moving ahead:
UPDATE User SET city = 'Lahore' WHERE userId = 2; 
UPDATE Card SET cardTypeID = 2, balance = 15000 WHERE cardNum = '1236';
UPDATE `Transaction` SET amount = 3000 WHERE cardNum = '1236'; */
UPDATE user SET city = 'Lahore' WHERE userId = 2; 
UPDATE card SET cardTypeId = 2, balance = 15000 WHERE cardNum = '1236';
UPDATE `transaction` SET amount = 3000 WHERE cardNum = '1236';

/* 5. Write a query to display the user name, card number, card type, transaction date, transaction amount, and card 
   balance for all users who:
		• Live in "Lahore",
		• Have a card of type "Credit",
		• Have made transactions greater than 2000,
		• And whose card balance is greater than 10,000.*/
select U.name, C.cardNum, CT.name, T.transDate, T.amount, C.balance
from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
join cardType as CT on CT.cardTypeId = C.cardTypeId
join transaction as T on C.cardNum = T.cardNum
where U.city = "Lahore" and CT.name = "Credit" and T.amount > 2000 and C.balance > 10000;


----------------------------------- Task 4 -----------------------------------
/* 1. Find all users who have both a debit card and a credit card. */
select U.name from user as U
join userCard as UC1 on U.userId = UC1.userId
join card as C1 on UC1.cardNum = C1.cardNum
join cardType as CT1 on C1.cardTypeID = CT1.cardTypeID
join userCard as UC2 on U.userId = UC2.userId
join card as C2 on UC2.cardNum = C2.cardNum
join cardType as CT2 on C2.cardTypeID = CT2.cardTypeID
where CT1.name = "Debit" and CT2.name = "Credit";

select U.name from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
join cardType as CT on C.cardTypeID = CT.cardTypeID
where CT.name in ("Credit", "Debit")
group by U.userId
having count(distinct CT.name) = 2;

/* 2. List users who have made transactions on cards that will expire within the next 30 days.
   Note: you can use  Date_Add(Current_Date , Interval 30 Day)  to add 30 days */
select U.name from user as U
join userCard as UC on U.userId = UC.userId
join card as C on UC.cardNum = C.cardNum
join transaction as T on C.cardNum = T.cardNum
where C.expireDate between current_date() and date_add(current_date(), interval 30 day);

/* 3. find cards that share the same balance but are owned by different users. */
select C1.cardNum as Card1, C2.cardNum as Card2, C1.balance
from card as C1
join card as C2 on C1.balance = C2.balance and C1.cardNum != C2.cardNum
join userCard as UC1 on C1.cardNum = UC1.cardNum
join userCard as UC2 on C2.cardNum = UC2.cardNum
where UC1.userId != UC2.userId;