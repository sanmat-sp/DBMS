CREATE TABLE STUDENT_385 (
Name varchar(30) not null,
StudentNumber int not null,
Class int not null,
Major varchar(4),
CONSTRAINT STUDENT_385_pk PRIMARY KEY(StudentNumber)
);
CREATE TABLE COURSE_385 (
CourseName varchar(30) not null,
CourseNumber varchar(8) not null,
CreditHours int not null,
Department varchar(4),
CONSTRAINT COURSE_385_pk PRIMARY KEY(CourseNumber)
);
CREATE TABLE SECTION_385 (
SectionIdentifier int not null,
CourseNumber varchar(8) not null,
Semester varchar(6) not null,
Year int not null,
Instructor varchar(30) not null,
CONSTRAINT SECTION_385_pk PRIMARY KEY(SectionIdentifier),
CONSTRAINT SECTION_385_cn_fk FOREIGN KEY(CourseNumber) REFERENCES
COURSE_385(CourseNumber) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE GRADE_REPORT_385 (
StudentNumber int not null,
SectionIdentifier int not null,
Grade char(1),
CONSTRAINT GRADE_REPORT_385_pk PRIMARY KEY(StudentNumber,SectionIdentifier),
CONSTRAINT GRADE_REPORT_385_sn_fk FOREIGN KEY(StudentNumber)
REFERENCES STUDENT_385(StudentNumber) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT GRADE_REPORT_385_si_fk FOREIGN KEY(SectionIdentifier)
REFERENCES SECTION_385(SectionIdentifier) ON DELETE CASCADE ON UPDATE
CASCADE
);
CREATE TABLE PREREQUISITE_385 (
CourseNumber varchar(8) not null,
PrerequisiteNumber varchar(8) not null,
CONSTRAINT PREREQUISITE_pk PRIMARY KEY(CourseNumber,PrerequisiteNumber),
CONSTRAINT PREREQUISITE_385_cn_fk FOREIGN KEY(CourseNumber)
REFERENCES COURSE_385(CourseNumber) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PREREQUISITE_385_pn_fk FOREIGN KEY(PrerequisiteNumber)
REFERENCES COURSE_385(CourseNumber) ON DELETE CASCADE ON UPDATE CASCADE
); 



INSERT into STUDENT_385 values
('Madhavan',154,3,'CS'),
('Ram',15,4,'CS'),
('Akash',17,4,'CS');
INSERT into COURSE_385 values
('DSA','16CS237',4,'CS'),
('DBMS','16CS154',4,'CS'),
('DMS','16CS243',3,'CS'),
('OS','16CS180',3,'CS');
INSERT into SECTION_385 values
(1,'16CS243','3',2001,'Prof1'),
(2,'16CS237','3',2003,'Prof2'),
(3,'16CS154','5',2005,'Prof3'),
(4,'16CS243','3',2006,'Prof4'),
(5,'16CS237','3',2019,'Prof2'),
(6,'16CS180','3',2004,'Prof5');
INSERT into GRADE_REPORT_385 values
(154,4,'C'),
(154,5,'B'),
(15,1,'A'),
(15,2,'A'),
(15,3,'A'),
(15,6,'A'),
(17,4,'C'),
(17,5,'B');
INSERT into PREREQUISITE_385 values
('16CS180','16CS154'),
('16CS180','16CS243'),
('16CS154','16CS237');

--1
SELECT CourseName FROM COURSE_385 JOIN SECTION_385 ON COURSE_385.CourseNumber = SECTION_385.CourseNumber WHERE SECTION_385.Year BETWEEN "2001" AND "2004";



--2
create table Student_Report_385 as select StudentNumber, CourseNumber, case
when Grade = 'A' then 100
when Grade = 'B' then 90
when Grade = 'C' then 80
end as Marks
from grade_report_385 natural join section_385 natural join COURSE_385

--3
create table student_statistics_385(
totalmarks int not null,
avgmarks int not null
);

delimiter //
create trigger save_current_total_avg
after insert
on Student_Report_385 for each row
begin
    insert into student_statistics_385(totalmarks, avgmarks)
    select sum(marks), (sum(marks) / count(*))
    from Student_Report_385;
end//
delimiter ;