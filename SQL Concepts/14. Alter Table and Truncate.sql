/* 
ALTER TABLE : To modify the schema/design (column, datatype, constraint).

--> ADD COLUMN
ALTER TABLE table_name
ADD COLUMN column_name datatype constraint;

--> DROP COLUMN
ALTER TABLE table_name
drop COLUMN column_namet;

--> RENAME TABLE
ALTER TABLE table_name
RENAME TO new_table_name;

--> CHANGE COLUMN (rename)
ALTER TABLE table_name
CHANGE COLUMN old_name new_name constraint datatype;

--> MODIFY COLUMN (modify constraint/datatype)
ALTER TABLE table_name
modify col_name new_datatype new_constraint;

--> TRUNCATE : Removes the data from the table
Difference b/w DROP TABLE and TRUNCATE TABLE 
DROP deletes the table along with it's data while TRUNCATE only deletes the data inside the table.
*/

create table student2 (
	rollno int primary key,
    name varchar(20) not null,
    marks int not null,
    grade varchar(1) not null,
    city varchar(20) not null
);

insert into student2 values
(2, "Ahmad", 92, "A", "Lahore"),
(6, "Bakar", 85, "A", "Lahore"),
(14, "Rafay", 78, "B", "Lahore"),
(23, "Moin", 88, "A", "Okara"),
(31, "Junaid", 78, "B", "Lahore"),
(43, "Subhan", 75, "B", "Lahore"),
(44, "Jafry", 72, "B", "Lahore"),
(46, "Sherry", 70, "B", "Lahore");

select * from student2;

alter table student2 add column age int not null default 20;

alter table student2 drop column age;

alter table student2 rename to student3;
alter table student3 rename to student2;

alter table student2 change age height int;
alter table student2 change height age int;	

alter table student2 modify age double not null;
alter table student2 modify age int;

truncate table student2;