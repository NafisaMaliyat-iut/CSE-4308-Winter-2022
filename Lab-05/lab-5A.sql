conn system/123;

conn S200042133/nafisamaliyat;

@C:\Users\user\Documents\DBMS_LAB\Lab-5A\DDL+drop.sql;

@C:\Users\user\Documents\DBMS_LAB\Lab-5A\smallRelationsInsertFile.sql;

--1--
create or replace view Advisor_Selection as
    select ID, name, dept_name 
    from instructor;

--2--
create or replace view Student_Count as 
    select name, (select count(s_id) 
                  from advisor
                  group by i_id
                  having i_id = Advisor_Selection.ID) as st_count
    from Advisor_Selection
    where Advisor_Selection.ID in (select i_id
                                    from advisor);


--3a--
drop role student;
create role student;
grant select on S200042133.Advisor_Selection to student;
grant select on S200042133.course to student;

--3b--
drop role Course_Teacher;
create role Course_Teacher;
grant select on S200042133.student to Course_Teacher;
grant select on S200042133.course to Course_Teacher;

--3c--
drop role HeadOfDepartment;
create role HeadOfDepartment;
grant Course_Teacher to HeadOfDepartment;
grant insert, select on S200042133.instructor to HeadOfDepartment;

--3d--
drop role Administrator;
create role Administrator;
grant select on S200042133.department to Administrator;
grant select on S200042133.instructor to Administrator;
grant update(budget) on S200042133.department to Administrator;




--4--

--creating users--


--student--
drop user student1;
create user student1 identified by 1234;
grant student to student1;
grant create session, resource to student1;



--course teacher--
drop user Course_Teacher1;
create user Course_Teacher1 identified by 1234;
grant Course_Teacher to Course_Teacher1;
grant create session, resource to Course_Teacher1;



--Head of department--
drop user HeadOfDepartment1;
create user HeadOfDepartment1 identified by 1234;
grant HeadOfDepartment to HeadOfDepartment1;
grant create session, resource to HeadOfDepartment1;



--Administrator--
drop user Administrator1;
create user Administrator1 identified by 1234;
grant Administrator to Administrator1;
grant create session, resource to Administrator1;




--TESTING--


--student--
conn student1/1234;

select * from S200042133.course;
select * from S200042133.Advisor_Selection;

alter table S200042133.course rename to courses;
select * from S200042133.instructor;




--course teacher--
conn Course_Teacher1/1234;

select * from S200042133.course;
select * from S200042133.student;

alter table S200042133.course rename to courses;




--head of department--
conn HeadOfDepartment1/1234;

select * from S200042133.student;
select * from S200042133.course;
insert into S200042133.instructor values('33445', 'Sangwoo', 'Physics', 50000);

insert into S200042133.student values('98875', 'Park', 'Biology', 56);





--administrator--
conn Administrator1/1234;

select * from S200042133.department;
select * from S200042133.instructor;
update S200042133.department set budget = 400
    where dept_name = 'Biology';
update S200042133.department set budget = 90000
    where dept_name = 'Biology';

insert into S200042133.department values('Psychology', 'Watson', 12400);
