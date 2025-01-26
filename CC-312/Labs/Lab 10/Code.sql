----------------------------------- Task 1 -----------------------------------
-- Library Management System Schema
create table PATRON (
    pat_id int primary key,
    pat_fname varchar(50),
    pat_lname varchar(50),
    pat_type varchar(20)
);

create table BOOK (
    book_num int primary key,
    book_title varchar(100),
    book_year int,
    book_cost decimal(10, 2),
    book_subject varchar(50),
    pat_id int,
    foreign key (pat_id) references PATRON(pat_id)
);

create table AUTHOR (
    au_id int primary key,
    au_fname varchar(50),
    au_lname varchar(50),
    au_birthyear int
);

create table WRITES (
    book_num int,
    au_id int,
    primary key (book_num, au_id),
    foreign key (book_num) references BOOK(book_num),
    foreign key (au_id) references AUTHOR(au_id)
);

create table CHECKOUT (
    check_num int primary key,
    book_num int,
    pat_id int,
    check_out_date date,
    check_due_date date,
    check_in_date date,
    foreign key (book_num) references BOOK(book_num),
    foreign key (pat_id) references PATRON(pat_id)
);


----------------------------------- Task 2 -----------------------------------
-- LargeCo Company Schema
create table LGCUSTOMER (
    cust_code int primary key,
    cust_fname varchar(50),
    cust_lname varchar(50),
    cust_street varchar(100),
    cust_city varchar(50),
    cust_state varchar(50),
    cust_zip varchar(10),
    cust_balance decimal(10, 2)
);

create table LGEMPLOYEE (
    emp_num int primary key,
    emp_fname varchar(50),
    emp_lname varchar(50),
    emp_email varchar(100),
    emp_phone varchar(20),
    emp_hiredate date,
    emp_title varchar(50),
    emp_comm decimal(10, 2),
    dept_num int,
    foreign key (dept_num) references LGDEPARTMENT(dept_num)
);

create table LGDEPARTMENT (
    dept_num int primary key,
    dept_name varchar(50),
    dept_mail_box varchar(50),
    dept_phone varchar(20),
    emp_num int,
    foreign key (emp_num) references LGEMPLOYEE(emp_num)
);

create table LGPRODUCT (
    prod_sku int primary key,
    prod_descript varchar(255),
    prod_type varchar(50),
    prod_base varchar(50),
    prod_category varchar(50),
    prod_price decimal(10, 2),
    prod_on_hand int,
    prod_min int,
    brand_id int,
    foreign key (brand_id) references LGBRAND(brand_id)
);

create table LGBRAND (
    brand_id int primary key,
    brand_name varchar(50),
    brand_type varchar(50)
);

create table LGVENDOR (
    vend_id int primary key,
    vend_name varchar(100),
    vend_street varchar(100),
    vend_city varchar(50),
    vend_state varchar(50),
    vend_zip varchar(10)
);

create table LGSUPPLIES (
    vend_id int,
    prod_sku int,
    primary key (vend_id, prod_sku),
    FOREIGN KEY (vend_id) references LGVENDOR(vend_id),
    FOREIGN KEY (prod_sku) references LGPRODUCT(prod_sku)
);

create table LGINVOICE (
    inv_num int primary key,
    cust_code int,
    inv_date date,
    inv_total decimal(10, 2),
    employee_id int,
    foreign key (cust_code) references LGCUSTOMER(cust_code),
    foreign key (employee_id) references LGEMPLOYEE(emp_num)
);

create table LGLINE (
    inv_num int,
    line_num int,
    prod_sku int,
    line_qty int,
    line_price decimal(10, 2),
    primary key (inv_num, line_num),
    foreign key (inv_num) references LGINVOICE(inv_num),
    foreign key (prod_sku) references LGPRODUCT(prod_sku)
);

create table LGSALARY_HISTORY (
    emp_num int,
    sal_from date,
    sal_end date,
    sal_amount decimal(10, 2),
    primary key (emp_num, sal_from),
    foreign key (emp_num) references LGEMPLOYEE(emp_num)
);
