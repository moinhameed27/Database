----------------------------------- Task 1 -----------------------------------
/* 1. Find the occurrence of letter ‘M’ in Job and display if it is greater than 0. */
select ename, job, length(job) - length(replace(job, "M", "")) as occurrences
from EMP where length(job) - length(replace(job, "M", "")) > 0;

/* 2. Remove the left and right spaces from the string  “       I Love Pakistan         ”. */
select trim("       I Love Pakistan         ") as trimmed_word;

/* 3. In this string “       I Love Pakistan         ”  Replace "Pakistan" with "Country", remove 
   leading and trailing spaces, and extract the entire modified string. */
select trim(replace("       I Love Pakistan         ", "Pakistan", "Country")) as replaced_word;

/* 4. Display the name of emp that contain first 2character uppercase and last 2 character lower case. */
select concat( upper(left(ename, 2)), lower(right(ename, 2)) ) as new_word from EMP;

/* 5. Extract the first 3 characters of the JOB field, add of job length “*” on the left side and add “– “ on 
Right side, and reverse the extracted portion of the job.  */
select job, substr(job, 1, 3) as job_prefix, 
lpad( substr(job, 1, 3), length(job) + 3, "*" ) as left_added_prefix,
rpad( substr(job, 1, 3), length(job) + 3, "-" ) as right_added_prefix, 
reverse(substr(job, 1, 3)) as reversed_prefix from EMP;

/* 6. Display those employees whose concatenated salary and employee number(empno) has an odd length. */
select ename, sal, empno, 
concat( cast(sal as char), cast(empno as char) ) as concat_value,
length(concat(cast(sal as char), cast(empno as char))) as len from EMP 
where length( concat(cast(sal as char), cast(empno as char)) ) % 2 = 1;

/* 7. Retrieve the salary (SAL), job title (JOB), and employee name (ENAME) from the "EMP" table. If the 
   salary is greater than 2500, the job title is "MANAGER", and the number of characters in the employee's 
   name (after removing all occurrences of the letter 'A') is even, the employee's name will be displayed 
   in uppercase; otherwise, it will be displayed in lowercase. */
select sal, if(sal > 2500, "MANAGER", job) as job, 
if( length( replace(ename, "A", "") ) % 2 = 0 , upper(ename), lower(ename))
as ename from EMP;

/* 8. Write a SQL query to retrieve the employee name (ENAME) and job title (JOB) from the EMP table. In 
   the job title, replace the second character of the employee's job with the second character of their 
   name. Display the employee name, job title, and the modified job title as "MODIFIED_JOB." */
select ename, job, replace(job, substr(job, 2, 1), substr(ename, 2, 1)) as replaced_word from EMP;


----------------------------------- Task 2 -----------------------------------
/* 1. List all the employee whose length of salary is divisible by 4( . and onward not include as length count) 
   and hired in leap year. */
select ename, hiredate, sal from EMP where length(cast(sal as char) - 3) % 4 = 0 and ( (year(hiredate) % 4 = 0
and year(hiredate) % 100 != 0 ) or year(hiredate) % 400 = 0 );

/* 2. Retrieve the employee name (ENAME), job title (JOB), and a string displaying the total length of the 
   employee name (or "ANONYMOUS" if the name is NULL) and the job title combined, followed by a hyphen, and 
   the length of the job title with all occurrences of the letters 'A' and 'E' removed from the "EMP" table. */
select ename, job, 
concat(cast(length(ename) + length(job) as char), " - ", length(replace(replace(job, "A", ""), "E", ""))) 
as EMP_CODE from EMP;

/* 3. Count the number of occurrences of vowel letters and consonant letters in the 
   concatenated ENAME and JOB fields. */
select concat(ename, job) as ENAME_JOB, 
length(concat(ename, job)) - length(replace(replace(replace(replace(replace(concat(ename, job), "A", ""), "E", ""), "I", ""), "O", ""), "U", "")) as vowel_count,
length(replace(replace(replace(replace(replace(concat(ename, job), "A", ""), "E", ""), "I", ""), "O", ""), "U", ""))
as consonants_count from EMP;

 /* 4. Write a query that performs the following operations on the ENAME field from the EMP  table:
        a. Extract the part of the employee name that comes before the first occurrence of the letter A.
        b. Calculate the total length of the employee name. 
        c. Replace all occurrences of the letter 'I' in the employee name with the '@' symbol.
        d. Extract the first 3 letters of the employee name. 
        e. Extract the last 2 letters of the employee name. 
        f. Create a shortened job title by combining the first 3 characters and the last 3 characters 
        of the job title, with '...' in between. Apply filter where Length of employee name is greater than 4. */
select ename, substr(ename, 1, instr(ename, "A") - 1) as before_A,
length(ename) as len, replace(ename, "I", "@") as replaced_word, left(ename, 3) as first_3,
right(ename, 2) as last_2, concat( left(job, 3), "...", right(job, 3) )
from EMP where length(ename) > 4;

/* 5. Display ename  , empno , Job , “Modified Column” that replace the first 3 character of ename with the 
   last 3 job characters and pad the characters of job with # . Count of # on each side should be equal to 
   the last number in empno. */
select ename, empno, job, 
concat(repeat("#", empno % 10), replace(ename, left(ename, 3), right(job, 3)), repeat("#", empno % 10) ) 
as modified_column from EMP;

/* 6.  Write a query:   
			a. For each employee, print 'ghost' if ename is null, otherwise display the actual ename.
			b. Add the sal column with 'X' on the right if the salary is greater than 3000, otherwise 
               add with 'Y' on the left until it is 8 characters long.
			c. Modify ename to lowercase if it contains the letter 'O', otherwise display it in uppercase. If 
               ename is null, display ghost.
			d. Generate an email for each employee in the format name@gmail.com. */
select ifnull(ename, "GHOST") as ename,
if(sal > 3000, rpad(sal, 8, "X"), lpad(sal, 8, "Y")) as XY,
if(ename is not null, if(ename like "%O%", lower(ename), upper(ename)), "GHOST") as new_name,
concat(lower(ename), "@gmail.com") as email from EMP;

/* 7. Write a query that Calculates the tax for each employee based on their salary Tax brackets:
        a. Salary up to 2000: 5% tax
        b. Salary between 2001 and 4000: 10% tax
        c. Salary above 4000: 15% tax
	Displays the final salary after deducting the calculated tax and display the employee’s name and 
    job title, formatted as Ename(JOB) eg. Smith(Clerk) */
select concat(ename, "(", job, ")") as name_job, sal, 
case when sal <= 2000 then sal * 0.05 when sal <= 4000 then sal * 0.1 else sal * 0.15 end as tax,
sal - case when sal <= 2000 then sal * 0.05 when sal <= 4000 then sal * 0.1 else sal * 0.15 end as new_sal from EMP;


----------------------------------- Task 3 -----------------------------------
/* 1. Write a query that performs the following operations:
			a. For each employee, pad the (salary) column with leading zeros until it is 6 digits long. If 
               the salary is missing (NULL), display 'N/A' instead.
			b. For the (commission) column, the value with '*' until it is 4 characters long. If the 
               commission is missing (NULL), display 'N/A' instead.
			c. Calculate the length of the salary column
			d. Concatenate a statement that includes the employee's uppercase ename, the salary (where 
               all zeros are replaced with '#'), and the phrase "per month." The number of “#” that added on 
			   left side of salary is determined by the combined length of the employee's job title and ename.
			e. Also apply the filter of salary greater than thousand. */
select ename, if(job is not null, lpad(sal, 6, "0"), "N/A") as sal, 
if(comm is not null, lpad(comm, 4, "0"), "N/A") as comm, length(sal) as len,
concat(upper(ename), " earns ", lpad(replace(sal, "0", "#"), length(job) + length(ename), "#"), " per month.")
as salary_statement from EMP where sal > 1000;
 
/* 2. Write a SQL query to retrieve the exact same output. */
select ename, job, left(job, 5) as job_l, right(job, 5) as job_r,
concat( repeat(substr(job, 1, 1), 2) , repeat(substr(job, 2, 1), 2) , repeat(substr(job, 3, 1), 2) , 
repeat(substr(job, 4, 1), 2) , repeat(substr(job, 5, 1), 2) ) as forward_repeat,
reverse( concat( repeat(substr(job, 1, 1), 2) , repeat(substr(job, 2, 1), 2) , repeat(substr(job, 3, 1), 2) , 
repeat(substr(job, 4, 1), 2) , repeat(substr(job, 5, 1), 2) ) ) as reverse_repeat
FROM EMP;

/* 3. Write a query that performs the following operations: 
		a. For each employee, add the * on both sides of ename, the count of * should equal to the vowels 
           count in the ename .
		b. Extract and reverse the middle part of the ename.
		c. For the job column, replace all vowels with the '@' symbol.  */
select ename, 
concat(
	repeat("*", length(ename) - length(replace(replace(replace(replace(replace(ename, "A", ""), "E", ""), "I", ""), "O", ""), "U", ""))),
    ename, 
    repeat("*", length(ename) - length(replace(replace(replace(replace(replace(ename, "A", ""), "E", ""), "I", ""), "O", ""), "U", "")))
    ) as padded_name,
reverse(substr(ename, 2, length(ename) - 2)) as reverse_middle,
replace(replace(replace(replace(replace(job, "A", "@"), "E", "@"), "I", "@"), "O", "@"), "U", "@") as removed_vowels
from EMP;