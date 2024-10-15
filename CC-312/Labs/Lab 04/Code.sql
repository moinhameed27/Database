----------------------------------- Task 1 -----------------------------------
/* 1. Create a database named STUDENTCOURSEDB. */
create database STUDENTCOURSEDB;

/* Create Table Student
Table Name : Student
* Col Name
* Data Type
* constraints
1. StudentID
   CHAR(5)
   Primary Key
2. FirstName
   VARCHAR2(20)
   Not Null
3. LastName
   VARCHAR2(30)
   Not Null
*/

create table student (
	studentId char(5) primary key,
    firstname varchar(20) not null,
    lastname varchar(30) not null
);

/* Create table Class 
Table Name : Class
* Col Name
* Data Type
* constraints
1. Class_Code
   CHAR(5)
   Primary Key,Not Null
2. Course_Code
   Char(5)
   Not Null
3. Class_Section
   Int
   Not Null
4. Class_Room
   Varchar2(10)
   Unique
5. Class_Teacher
   Varchar2(10)
   Not Null
*/

create table class (
	classCode char(5) primary key not null,
    courseCode char(5) not null,
    classSection int not null,
    classroom varchar(10) unique,
    classTeacher varchar(10) not null
);

/* Create Table Enrollment
Table Name : Enrollment
* Col Name
* Data Type
* constraints
1. Class_Code
   CHAR(5)
   Not Null,references (Class)
2. StudentID
   Char(5)
   Primary key,Not Null,references (Student)
3. Enroll_Grade
   Char(1)
*/

create table enrollment (
	classCode char(5) not null,
    studentId char(5) primary key not null,
    enrollGrade char(1) not null,
    constraint fk_class_code foreign key (classCode) references class(classCode),
    constraint fk_student_id foreign key (studentId) references student(studentId)
);

----------------------------------- Task 2 -----------------------------------
/* Insert records into the tables with the following data: */
/* 1. 
StudentID  FirstName  LastName
   S001      John       Doe
   S002     Alice      Smith
   S003      Bob      Johnson
   S004      Mary      Brown
   S005     James     Williams
*/
insert into student values
("S001", "John", "Doe"),
("S002", "Alice", "Smith"),
("S003", "Bob", "Johnson"),
("S004", "Mary", "Brown"),
("S005", "James", "Williams");

/* 2. 
Class_Code  Course_Code  Class_Section  Class_Room  Class_Teacher
   C101        CS101		   1 			1         Dr. White
   C102 	   CS102           2			2		  Dr. Green
   C103 	   CS103 		   3 			3 		  Dr. Black
*/
insert into class values
("C101", "CS101", 1, "1", "Dr. White"),
("C102", "CS102", 2, "2", "Dr. Green"),
("C103", "CS103", 3, "3", "Dr. Black");

/* 3.
Class_Code  Student_ID  Enroll_Grade
   C101		   S001			 A
   C102		   S002			 B
   C103		   S003			 C
   C101  	   S004  		 A
*/
insert into enrollment values
("C101", "S001", "A"),
("C102", "S002", "B"),
("C103", "S003", "C"),
("C101", "S004", "A");

----------------------------------- Task 3 -----------------------------------

SET SQL_SAFE_UPDATES = 0; /* (For Update Queries) */

/* 1. Update the Class_Teacher for class C101 to "Dr. Smith", and also set Class_Section to 2. */
update class set classSection = 2, classTeacher = "Dr. Smith" where classCode = "C101";

/* 2. Change the LastName of a student where StudentID is 'S001' to "Johnson" and update FirstName to "Johnny". */
update student set firstName = "Johny", lastName = "Johnson" where studentId = "S001";

/* 3. Update the LastName of students who have letter "B" in their first Name or Last Name and set their Last Name to "Green”. */
update student set lastName = "Green" where firstName like "%B%" or lastName like "%B%";

/* 4. Update all classes to have Class_Section increased by 1 where the current Class_Section is less than 3. */
update class set classSection = classSection + 1 where classSection < 3;


----------------------------------- Task 4 -----------------------------------
/* 1. Add a new column named AdmissionDate to the Student table, and set the default value to the current date. */
alter table student 
add column AdmissionDate date default (current_date);

/* 2. Change the data type of Class_Section in the Class table to TINYINT. */
alter table class
modify classSection tinyint;

/* 3. Add a unique constraint to the Course_Code column in the Class table. */
alter table class
modify courseCode char(5) unique;


----------------------------------- Task 5 -----------------------------------
/* 1. Retrieve the first name and last name of students along with their class codes. */
select S.firstName, S.lastName, E.classCode
from enrollment as E join student as S
on S.studentId = E.studentId;

/* 2. Display the first name, last name of students, class room, and class teacher. */
select S.firstName, S.lastName, C.classroom, C.classTeacher
from enrollment as E join student as S, class as C
where E.classCode = C.classCode and E.studentId = S.studentId;

/* 3. Show class code, class section, and student names for each class. */
select C.classCode, C.classSection, S.firstName
from enrollment as E join student as S, class as C
where E.classCode = C.classCode and E.studentId = S.studentId;


----------------------------------- Task 6 -----------------------------------
/* 1. Set up cascading deletion so that if a record in the Class table is deleted, the corresponding records in the Enrollment table are also removed. */
alter table enrollment
drop foreign key fk_class_code;

alter table enrollment
add constraint fk_class_code
foreign key (classCode) references class(classCode)
on delete cascade;

/* 2. Test this by deleting the class record with Class_Code 'C101', and verify that all related enrollments are deleted. */
delete from class where classCode = "C101";

/* 3. Enable cascading deletion from Student to Enrollment so that deleting a student also removes their enrollments. */
alter table enrollment
drop foreign key fk_student_id;

alter table enrollment
add constraint fk_student_id
foreign key (studentId) references student(studentId)
on delete cascade;

/* 4. Delete a student with StudentID 'S002' and verify that the enrollment record for 'S002' is also removed. */
delete from student where studentId = "S002";


----------------------------------- Task 7 -----------------------------------
/* 1. Delete all students from the Student table where LastName is either 'Smith' or 'Williams'. */
delete from student where lastName in ("Smith", "Williams");

/* 2. Delete all classes where the Class_Section is an odd number. */
delete from class where classSection % 2 = 1;


----------------------------------- Task 8 -----------------------------------
/* Drop the Enrollment table and the Class table. */
drop table enrollment, class;