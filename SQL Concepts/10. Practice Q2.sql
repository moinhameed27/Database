
/* Q1 :  Find average marks in each city ascending order. */

select city, avg(marks) from student group by city order by avg(marks) asc;

/* Q2 : Customer table showing payment done by each method */

create table customer (
	id int primary key,
    name varchar(20) not null,
    mode varchar(20) not null,
    city varchar(20) not null
);

insert into customer values 
(101, "Moin", "Credit Card", "Okara"),
(102, "Shan", "Debit Card", "Chunian"),
(103, "Zeeshan", "Netbanking", "Lahore"),
(104, "Sherry", "Credit Card", "Okara"),
(105, "Ahmad", "Debit Card", "Lahore"),
(106, "Juni", "Credit Card", "Lahore"),
(107, "Subhan", "Debit Card", "Lahore"),
(108, "Moiz", "Credit Card", "Chunian"),
(109, "Jafry", "Netbanking", "Lahore"),
(110, "Bakar", "Debit Card", "Lahore"),
(111, "Rafay", "Netbanking", "Lahore");

select * from customer;

select mode, count(id), city from customer group by mode, city;
