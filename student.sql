create table STUDENT (
    usn int primary key,
    sname varchar(20),
    address varchar(25),
    phone INT,
    gender CHAR
);

create table SEMSEC(
    ssid int primary key,
    sem int,
    sec char
);

create table CLASS(
    usn int,
    ssid int ,
    primary key(usn,ssid),
    foreign key(usn) references STUDENT(usn),
    foreign key(ssid) references SEMSEC(ssid)
);

create table SUBJECT(
    subcode int primary key,
    title varchar(20),
    sem int,
    credits int
);

create table IAMARKS(
    usn int,
    subcode int,
    ssid int ,
    primary key(usn,ssid,subcode),
    test1 int,
    test2 int,
    test3 int,
    finalIA int,
    foreign key(usn) references STUDENT(usn),
    foreign key(ssid) references SEMSEC(ssid),
    foreign key(subcode) references SUBJECT(subcode)
);


// insertion statements 

insert into STUDENT values(
    161,
    'Swaroop',
    'Bangalore',
    541236,
    'M'
);


insert into STUDENT values(
    162,
    'Tejavo',
    'Bangalore',
    612551,
    'M'
);


insert into STUDENT values(
    163,
    'Aditya',
    'Mysore',
    215536,
    'M'
);


insert into STUDENT values(
    164,
    'Anjali',
    'Mysore',
    225736,
    'F'
);

insert into STUDENT values(
    165,
    'Sharada',
    'Bangalore',
    458796,
    'F'
);

/////////////////////////////////////////////////////////////////

insert into SEMSEC values(
   500,
   4,
   'C'
);

insert into SEMSEC values(
   501,
   4,
   'C'
);

insert into SEMSEC values(
   502,
   4,
   'C'
);

insert into SEMSEC values(
   503,
   5,
   'B'
);

insert into SEMSEC values(
   504,
   5,
   'C'
);

///////////////////////////////////////////////////////////////////////////

insert into CLASS values(161,500);

insert into CLASS values(162,501);

insert into CLASS values(163,502);

insert into CLASS values(164,503);

insert into CLASS values(165,504);

///////////////////////////////////////////////////////////////////////////////

insert into SUBJECT values(
   1001,
   'DBMS',
   4,
   4
);

insert into SUBJECT values(
   1002,
   'CNS',
   4,
   3
);

insert into SUBJECT values(
   1003,
   'MAN',
   5,
   3
);

insert into SUBJECT values(
   1004,
   'UP',
   4,
   2
);

insert into SUBJECT values(
   1005,
   'ATC',
   4,
   1
);

/////////////////////////////////////////////////////////////

insert into IAMARKS(usn,subcode,ssid,test1,test2,test3) values(
    161,1001,500,50,50,50
);

insert into IAMARKS(usn,subcode,ssid,test1,test2,test3) values(
    162,1002,501,49,48,46
);

insert into IAMARKS(usn,subcode,ssid,test1,test2,test3) values(
    163,1003,502,35,42,45
);

insert into IAMARKS(usn,subcode,ssid,test1,test2,test3) values(
    164,1004,503,38,42,44
);

insert into IAMARKS(usn,subcode,ssid,test1,test2,test3) values(
    165,1005,504,49,46,38
);




table STUDENT;
table SEMSEC;
table CLASS;
table SUBJECT;
table IAMARKS;


/// QUERIES ///////////////


select * from STUDENT where usn in 
(select usn from CLASS where ssid in 
(select ssid from SEMSEC where sem=4 and sec='C'));


/// QUERIES ///////////////

select ss.sem,ss.sec,s.gender,count(s.gender) as count_ from STUDENT s,CLASS c,SEMSEC ss where 
s.usn = c.usn and c.ssid = ss.ssid group by sem,sec,gender order by sem;

///////////////////////////////


create view stud_test1_marks as select subcode,test1 from IAMARKS where USN =161;

//////////////////////////////////

update IAMARKS set finalIA=GREATEST(test1+test2,test2+test3,test1+test3)/2;


select s.usn,s.sname,s.address,s.phone,s.gender,
(
    case 
      when ia.finalia between 45 and 50
      then 'outstanding'
      when ia.finalia between 40 and 45
      then 'average'

    else
      'weak'
    END
) as CAT
from STUDENT s,IAMARKS ia,SUBJECT sub,SEMSEC ss where
s.usn = ia.usn and ss.ssid = ia.ssid and sub.subcode = ia.subcode and sub.sem=5;
