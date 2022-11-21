conn system/123;
conn S200042133/nafisamaliyat;


drop table admits;
drop table hospital;
drop table occurs;
drop table accident;
drop table driving_license;
drop table citizen;
drop table district;
drop table division;



create table division 
(
    name varchar2(30), 
    description varchar2(50), 
    constraint pk_division primary key(name)
);

create table district 
(
    name varchar2(30),
    description varchar2(50),
    division_name varchar2(20),
    constraint pk_district primary key(name),
    constraint fk_district_division foreign key(division_name) references division(name)
);

create table citizen 
(
    NID varchar2(13),
    name varchar2(30),
    date_of_birth date,
    occupation varchar2(20),
    blood_group varchar2(5),
    district_name varchar2(20),
    division_name varchar2(20),
    constraint pk_citizen primary key(NID),
    constraint fk_citizen_district foreign key(district_name) references district(name)
);

create table driving_license
(
    id varchar2(20),
    type_of_license varchar2(20),
    issue_date date,
    expire_date date,
    NID varchar2(13),
    constraint pk_driving_license primary key(id),
    constraint fk_driving_license_citizen foreign key(NID) references citizen(NID)
);

create table accident
(
    id varchar2(20),
    date_of_accident date,
    location varchar2(20),
    description varchar2(50),
    number_of_deaths int,
    constraint pk_accident primary key(id)
);

create table occurs
(
    accident_id varchar2(20),
    driving_license_id varchar2(20),
    constraint fk_accidents_driving_license foreign key(accident_id) references accident(id),
    constraint fk_accidents_accident foreign key(driving_license_id) references driving_license(id)
);


--create or replace type vmobiles as varray(5) of varchar2(20);

create table hospital
(
    name varchar2(30),
    phone_number varchar2(20),
    address varchar2(30),
    district_name varchar2(20),
    constraint pk_hospital primary key(name),
    constraint fk_hospital_district foreign key(district_name) references district(name)
);

create table admits 
(
    hospital_name varchar2(20),
    NID varchar2(13),
    description varchar2(50),
    admission_date date,
    release_date date,
    constraint fk_admits_hospital foreign key(hospital_name) references hospital(name),
    constraint fk_admits_citizen foreign key(NID) references citizen(NID)
);


--3a--
select division_name, count(name)
from district
group by division_name;

--3b--
select district_name 
from citizen 
group by district_name
having count(NID) >= 20000;

--3c--
select count(accident_id) 
from occurs
where driving_license_id = (select id 
                            from driving_license
                            where NID = 210);


--3d--
select * from
(select hospital_name 
from admits 
group by hospital_name
order by count(NID) desc)
where rownum=5;

--3e--
select blood_group 
from citizen
where NID in (select NID
                from admits);

--3f--
select count(citizen.NID)/count(district.name)
from citizen, district
where citizen.district_name = district.name
group by district.division_name, district.name;



--3g--
select * from
(select district_name
from citizen 
group by district_name
order by count(NID) desc)
where rownum = 3;

--3h--
select count(accident.id)
from accident, occurs, driving_license, citizen
where accident.id = occurs.accident_id
    and occurs.driving_license_id = driving_license.id
    and driving_license.NID = citizen.NID
group by citizen.district_name;

--3i--
select division_name
from 
(
    select district.division_name
    from accident, occurs, driving_license, citizen, district
    where accident.id = occurs.accident_id
    and occurs.driving_license_id = driving_license.id
    and driving_license.NID = citizen.NID
    and citizen.district_name = district.name
    group by district.division_name
    order by count(accident.id)
)
where rownum = 1;

--3j--
select count(accident_id)
from occurs
where driving_license_id in (select id 
                            from driving_license
                            where type_of_license = 'non-professional' or
                            type_of_license = 'professional');


--3k--
select NID
from admits
group by NID
having NID in ( select NID from 
                (select NID, max(release_date - admission_date)
                from admits
                group by NID));


--3l--
select name from
(
    select division.name, count(citizen.NID) as population
    from citizen, district, division
    where citizen.district_name = district.name
        and district.division_name = division.name
        and (sysdate - citizen.date_of_birth) between 15 and 30
    group by division.name
    order by population 
)
where rownum = 1;


--3m--
select citizen.name
from citizen, driving_license
where citizen.NID = driving_license.NID
    and driving_license.expire_date < sysdate;


--3n--
select count(occurs.accident_id)
from driving_license, occurs, accident 
where driving_license.id = occurs.driving_license_id
    and accident.id = occurs.accident_id
    and driving_license.expire_date < sysdate;

--3o--
select id
from driving_license
where id not in (select occurs.driving_license_id
                                from occurs);

--3p--
select sum(accident.number_of_deaths)
from accident, occurs, driving_license, citizen, district
where accident.id = occurs.accident_id
    and occurs.driving_license_id = driving_license.id
    and driving_license.NID = citizen.NID
    and citizen.district_name = district.name
group by district.division_name;

--3q--
select name
from citizen, driving_license
where citizen.NID = driving_license.NID
    and sysdate - citizen.date_of_birth < 22
    and sysdate - citizen.date_of_birth > 40;

--3r--
select citizen.NID
from citizen, admits, occurs, driving_license, accident
where citizen.NID = admits.NID
    and admits.admission_date = accident.date_of_accident
    and accident.id = occurs.accident_id
    and occurs.driving_license_id = driving_license.id
    and driving_license.NID = citizen.NID;


--3s--
select name from 
(
    (select name, count(NID) 
    from 
    (
    select hospital.name, admits.NID
    from hospital, admits, citizen, district
    where hospital.name = admits.hospital_name
        and citizen.NID = admits.NID
        and citizen.district_name = district.name 
        and district.division_name = 'Dhaka'
    )
    group by name
    order by count(NID) desc)
)
where rownum = 1;

--3t--
select accident.location, driving_license.NID 
from driving_license, occurs, accident, district, citizen
where driving_license.id = occurs.driving_license_id
    and accident.id = occurs.accident_id
    and district.name = citizen.district_name
    and district.name != location
    and citizen.NID = driving_license.NID; 
