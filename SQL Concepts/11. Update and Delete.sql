/* 
UPDATE : To update any existing data in the table.
By default Safe mode of SQL is on which don't allows updating any data, so first turn it off with 
*/
set sql_safe_updates = 0;

create table teacher
(
	id int primary key,
    name varchar(25),
    salary int unsigned not null
);

insert into teacher values 
(1, "adam", 25000),
(2, "bob", 30000),
(3, "casey", 40000);

select * from teacher;

update teacher set salary = 23000 where name = "adam";

/* To update all entries */
update teacher set salary = salary + 1000;

/* DELETE : removes the entire row from table or a whole table */

delete from teacher where name = "adam";

delete from teacher;




