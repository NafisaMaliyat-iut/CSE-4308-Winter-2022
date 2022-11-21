conn system/123;
conn S200042133/nafisamaliyat;

drop table issue_book;
drop table book_branches;
drop table book;
drop table publisher;
drop table book_issuer;
drop table employee_shift;
drop table employee;
drop table employee_type;
drop table shift;
drop table branch;




create table branch
(
    branch_id varchar2(8),
    location varchar2(20),
    year_of_establishment int,
    constraint pk_branch primary key(branch_id)
);


create table employee_type
(
    employee_type varchar2(10),
    base_salary numeric(6,2),
    house_allowance numeric(6,2) as (0.4 * base_salary),
    constraint pk_employee_type primary key(employee_type)
);

create table employee
(
    NID varchar2(13),
    name varchar2(30),
    blood_group varchar2(5),
    date_of_birth date,
    employee_type varchar2(12),
    constraint pk_employee primary key(NID),
    constraint fk_employee_employee_type foreign key(employee_type) references employee_type(employee_type)
);



create table shift
(
    start_time varchar2(10),
    duration varchar2(10),
    day_of_week varchar2(10),
    branch_id varchar2(8),
    constraint pk_shift primary key(day_of_week, start_time)
);

create table employee_shift
(
    day_of_week varchar2(10),
    start_time varchar2(10),
    NID varchar2(13),
    constraint fk_employee_employee_shift foreign key (NID) references employee(NID),
    constraint fk_shift_employee_shift foreign key (day_of_week, start_time) references shift(day_of_week, start_time)
);

create table publisher
(
    city varchar2(15),
    name varchar2(30),
    year_of_establishment int,
    constraint pk_publisher primary key(city, name)
);

create table book
(
    isbn varchar2(13),
    title varchar2(30),
    author varchar2(30),
    genre varchar2(20),
    price numeric(6,2),
    publisher_city varchar2(15),
    publisher_name varchar2(30),
    constraint fk_publisher_book foreign key (publisher_city, publisher_name) references publisher(city,name),
    constraint pk_book primary key(isbn)
);

create table book_branches
(
    isbn varchar2(13),
    branch_id varchar2(8),
    constraint fk_book_branches_book foreign key (isbn) references book(isbn),
    constraint fk_book_branches_branch foreign key(branch_id) references branch(branch_id)
);

create or replace view book_count as
    select count(isbn) as book_count
    from book_branches
    group by isbn, branch_id;


create table book_issuer
(
    name varchar2(30),
    date_of_birth date,
    hometown varchar2(20),
    occupation varchar2(20),
    username varchar2(30),
    constraint pk_user primary key(username)
);

create table issue_book
(
    issue_date date,
    number_of_days int default 15,
    username varchar2(30),
    NID varchar2(13),
    isbn varchar2(13),
    constraint pk_employee_issue_book foreign key (NID) references employee(NID),
    constraint pk_book_issue_book foreign key (isbn) references book(isbn),
    constraint pk_book_issuer_issue_book foreign key (username) references book_issuer(username)
);