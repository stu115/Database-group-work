/* Creation of researcher tables with constraints */
CREATE TABLE researcher 
(researcher_id VARCHAR2(5)constraint pk_researcher_researcher_id PRIMARY KEY,
 name VARCHAR2(100)constraint nn_researcher_first_name NOT NULL,
 phone_number VARCHAR2(14));

/* Additional constraint to check if name is in upper case */
ALTER TABLE researcher 
ADD CONSTRAINT check_name
CHECK 
(name= upper(name));

/* CREATE PROJECT TABLE */
CREATE TABLE project
(project_id NUMBER(4) constraint pk_project_project_id PRIMARY KEY,
description varchar2(100) constraint nn_project_topic NOT NULL,
budget NUMBER(8,2),
s_date DATE,
est_end_date DATE,
end_date DATE);

/* ADD additional CONSTRAINT */
ALTER TABLE project
ADD CONSTRAINT ck_est_end_date
CHECK(est_end_date > s_date) /*Check estimated date is greater than the start date */
ADD CONSTRAINT ck_end_date
CHECK(end_date > s_date);

/* CREATE TEAM PROJECT TABLE */
CREATE TABLE team_project
(role VARCHAR2(20) constraint nn_team_project_role NOT NULL,
project_id NUMBER(4),
researcher_id VARCHAR2(5),
CONSTRAINT fk1_team_project_project_id FOREIGN KEY (project_id) REFERENCES
project(project_id), /*Add FK constraint to table from project */
CONSTRAINT fk2_team_project_researcher_id  FOREIGN KEY (researcher_id) REFERENCES
researcher(researcher_id), /* Add FK consstraint to table from researcher */
CONSTRAINT fk1fk2 UNIQUE(project_id, researcher_id)
);

/*ADD CONSTRAINT TO ROLE */
ALTER TABLE team_project
ADD CONSTRAINT ck_team_project_role
CHECK(role IN('researcher', 'administrator', 'team leader'));

/* CREATE ORGANIZATION TABLE */
CREATE TABLE organization 
( orgid NUMBER(4) constraint pk_organization_orgid PRIMARY KEY,
name VARCHAR2(50) constraint nn_organization_name NOT NULL, /* name should not be null constraint */
p_number VARCHAR(14) constraint unique_organization_p_number UNIQUE, /* phone number is unique */
location VARCHAR(20) constraint nn_organization_location NOT NULL);

/* Create Sponsored table*/
CREATE TABLE sponsored
(orgid NUMBER(4),
project_id NUMBER (4),
 CONSTRAINT fk_sponsored_orgid FOREIGN KEY (orgid)
 REFERENCES organization(orgid),
 CONSTRAINT fk_sponsored_project_id  FOREIGN KEY (project_id)
 REFERENCES project(project_id),
 CONSTRAINT orgpro UNIQUE (orgid, project_id)); /*Constraint to make both fk unique for a combination */
 
 
/* Create expense table*/
CREATE TABLE expense
(e_date DATE constraint nn_expense_e_date NOT NULL,
description VARCHAR2(20) constraint nn_expense_description NOT NULL,
category VARCHAR2(20),
amount NUMBER(8,2),
researcher_id VARCHAR2(5),
project_id NUMBER(4),
constraint fk_expense_researcher_id FOREIGN KEY (researcher_id) REFERENCES 
researcher(researcher_id),
constraint fk_expense_project_id FOREIGN KEY (project_id) REFERENCES
project(project_id));

/* ADD CHECK CONSTRAINTS TO EXPENSE TABLE*/
ALTER TABLE expense
ADD CONSTRAINT check_category
CHECK(category = 'misc' or category = 'manpower') /*limit expense category to manpower or misc */
ADD CONSTRAINT check_description
CHECK( description IN ('travel','subsistence', 'accommodation','wages')) /*Limit description */
ADD CONSTRAINT check_amount 
CHECK(amount BETWEEN 1 AND 2000); /*Check amount of expenses */


/* Creation of Lecturer tables with constraints */
CREATE TABLE lecturer 
(guest_id  NUMBER(4) constraint pk_guest_lecturer_guest_id PRIMARY KEY,
first_name VARCHAR2(20) constraint nn_guest_lecturer_first_name NOT NULL,
last_name VARCHAR2(20) constraint nn_lecturer_last_name NOT NULL, 
email VARCHAR2(50),
researcher_id VARCHAR2(5),
CONSTRAINT fk_lecturer_researcher_id FOREIGN KEY (researcher_id) REFERENCES
researcher(researcher_id));

/* Create table with papers with constraints */
CREATE TABLE papers(
    pref NUMBER(5) constraint pk_papers_pref PRIMARY KEY,
    description VARCHAR2(50),
    Topic VARCHAR2(25) 
CONSTRAINT ck_papers_topic CHECK( topic IN ('history', 'finance', 'medical', 'law', 'IT')),
    p_date DATE DEFAULT SYSDATE, /*set to sysdate if null */
     Project_id NUMBER(4),
     constraint fk_papers_project_id FOREIGN KEY (project_id) REFERENCES
     project(project_id));


     /* Create journal table */
    CREATE TABLE journal
    (name VARCHAR2(20) CONSTRAINT nn_journal_name NOT NULL,
     jrid NUMBER  (4) CONSTRAINT pk_journal_pref PRIMARY KEY,
    rating NUMBER(1),
    pref NUMBER(5),
    constraint fk_journal_pref FOREIGN KEY (pref) REFERENCES
    papers(pref));
  
/* ADD CONSTRAINT TO JOURNAL table */
ALTER TABLE journal
ADD CONSTRAINT ck__name
CHECK(name in('london times','european times', 'new discoveries', 'world of ideas' ))
ADD CONSTRAINT ck_rating
CHECK(rating <= 4 );

/* Creation of students tables with constraints */
CREATE TABLE student
(Student_id NUMBER(6) constraint pk_student_student_id PRIMARY KEY,
first_name VARCHAR2(20) constraint nn_student_first_name NOT NULL,
last_name VARCHAR2(20) constraint nn_student_last_name NOT NULL, 
course VARCHAR2(50) constraint  nn_student_course NOT NULL);

/* Creation of lecture tables with constraints */
CREATE TABLE lecture 
(l_date DATE constraint nn_lecture_l_date NOT NULL, 
topic VARCHAR2(15) constraint nn_lecture_topic NOT NULL,
lecture_ref NUMBER(4) constraint pk_lecture_lecture_ref PRIMARY KEY, 
researcher_id VARCHAR2(5),
guest_id NUMBER(4),
room NUMBER(3), constraint ck_lecture_room CHECK(room BETWEEN 15 AND 100),
constraint fk_lecture_researcher_id FOREIGN KEY (researcher_id) REFERENCES
researcher(researcher_id));

/* Creation of attendance tables with constraints */
CREATE TABLE attendance 
(student_id NUMBER (6),
lecture_ref NUMBER(4),
feedback NUMBER(1),
constraint fk_attendance_student_id FOREIGN KEY (student_id) REFERENCES
student(student_id),
constraint fk_attendance_lecture_ref FOREIGN KEY (lecture_ref) REFERENCES
lecture(lecture_ref),
CONSTRAINT stulec UNIQUE(student_id, lecture_ref));

/* create sequence project primary key sequence 
Insertion of data within the project table */

CREATE sequence project_id_sequence
INCREMENT BY 1 
START WITH 325
MAXVALUE 9999
NOCYCLE;
/
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';
/

/*Insertion into coulmns  */
INSERT INTO project (project_id, description, s_date, est_end_date, end_date, budget)
VALUES(project_id_sequence.nextval, 'programming', '01/JAN/2019', '15/JAN/2019',
'18/JAN/2019', 450.31);
INSERT INTO project (project_id, description, s_date, est_end_date, end_date, budget)
VALUES(project_id_sequence.nextval, 'new law', '15/JAN/2019', '01/FEB/2019',
'05/FEB/2019', 721.22);
INSERT INTO project (project_id, description, s_date, est_end_date, end_date, budget)
VALUES(project_id_sequence.nextval, 'uk history', '10/FEB/2019', '20/FEB/2019',
'18/FEB/2019', 335.12);
INSERT INTO project (project_id, description, s_date, est_end_date, end_date, budget)
VALUES(project_id_sequence.nextval, 'chemistry', TO_DATE('11/FEB/2019', 
'DD/MON/YYYY'), TO_DATE('11/MAR/2019', 'DD/MON/YYYY'),  TO_DATE('20/MAR/2019', 'DD/MON/YYYY'), 
865.21);
INSERT INTO project (project_id, description, s_date, est_end_date, end_date, budget)
VALUES(project_id_sequence.nextval, 'Technology', '05/MAR/2019', '31/MAR/2019',
'15/MAR/2019',
 1001.00);

 /* INSERTION IN SPECIFIED project columns */
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'economics', '05/MAR/2019', '20/APR/2019', 821.00);
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'info systems', '21/FEB/2019', '31/MAR/2019', 1021.00);
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'mathematics', '11/MAR/2019', '01/APR/2019', 3220.00);

/* Update budget amount in project table for project 325*/
UPDATE project
SET budget = 2000
WHERE project_id = 326;

/* Update budget amount in project table for project 326*/
UPDATE project
SET budget = 1500
WHERE project_id = 327;

/* CREATE SEQUENCE for organization table */
CREATE sequence orgid_sequence
INCREMENT BY 1
START WITH 5012
MAXVALUE 9999
NOCYCLE;


/* Insert into organization table */
INSERT 
INTO organization 
VALUES(orgid_sequence.nextval, 'Apple', '213112341', 'london');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'Samsung', '518114678', 'berkshire');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'research it', '67823234', 'leeds');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'history channel', '4373759', 'london');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'KPMG', '2743292', 'london');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'fintech', '9823171', 'camden');
INSERT
INTO organization 
VALUES(orgid_sequence.nextval, 'medicare', '19231293', 'camden');

/* Insertion in sponsored table*/
INSERT ALL
INTO sponsored 
VALUES(5013, 326)
INTO sponsored 
VALUES(5013, 327)
INTO sponsored 
VALUES(5016, 329)
INTO sponsored 
VALUES(5017, 331)
INTO sponsored 
VALUES(5018, 330)
INTO sponsored 
VALUES(5019, 327)
SELECT *
FROM DUAL;

/* create sequence for researcher id no*/
CREATE sequence researcher_id_sequence
INCREMENT BY 1
START WITH 100
MAXVALUE 9999
NOCYCLE;

/* INSERT values within researcher table */
INSERT 
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'SINDE ABRAH', '612-86-4079');

INSERT 
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'JAMES FLEX', '123-45-222');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'OLIVIA PARRADICE', '213-32-2379');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'CECILE BRUIN', '602-69-9894');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'RAEANN BERK', '213-34-2222');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'JANESSA PAGAN', '602-69-9894');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'MALIA SEIG', '102-34-2134');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'NICK KYLES', '441-23-3455');
INSERT
INTO researcher VALUES
(researcher_id_sequence.NEXTVAL, 'STANDFORD WESLEY', '716-32-1123');

/* INSERT values within team project table */
INSERT ALL 
INTO team_project VALUES('team leader', 326, 101)
INTO team_project VALUES('administrator', 326, 102)
INTO team_project VALUES('researcher', 326, 103)
INTO team_project VALUES('researcher', 326, 105)
INTO team_project VALUES('researcher', 326, 106)
INTO team_project VALUES('team leader', 326, 107)
INTO team_project VALUES('researcher', 327, 108)
INTO team_project VALUES('team leader', 326, 109)
INTO team_project VALUES('administrator', 326, 108)
INTO team_project VALUES('team leader', 327, 101)
INTO team_project VALUES('researcher', 327, 102)
INTO team_project VALUES('administrator', 327, 103)
INTO team_project VALUES('researcher', 328, 102)
INTO team_project VALUES('researcher', 329, 103)
INTO team_project VALUES('researcher', 330, 103)
INTO team_project VALUES('researcher', 331, 104)
INTO team_project VALUES('researcher', 332, 104)
INTO team_project VALUES('researcher', 333, 105) 
INTO team_project VALUES('team leader', 332, 101)
SELECT * FROM DUAL;

/* Create sequence for lecturer pk id */
CREATE sequence guest_id_sequence
INCREMENT BY 5
START WITH 10
MAXVALUE 9999
NOCYCLE;

/* Create trigger for lecturer table to populate pk column*/
create or replace TRIGGER new_guest_id_befin
  BEFORE INSERT ON lecturer
  FOR EACH ROW
BEGIN
  SELECT guest_id_sequence.nextval
  INTO :new.guest_id
  FROM dual;
END;
/
INSERT 
INTO lecturer(researcher_id,first_name,  last_name, email)
VALUES ('101', 'Kimberlyn','Mulvy','kmulvy0@bloglovin.com');

INSERT ALL
INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('101',	'Kimberlyn',	'Mulvy',	'kmulvy0@bloglovin.com')
INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('101',	'Jemmy',	'Wigzell',	'jwigzell1@oaic.gov.au')
 INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('101',	'Jeth',	'Wollacott',	'jwollacott2@zdnet.com')
 INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('102',	'Dannie',	'Meins',	'dmeins3@spiegel.de')
INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('103',	'Marthe',	'Eidelman',	'meidelman4@princeton.edu')
 INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES('104',	'Dmitri',	'Leftly',	'dleftly5@typepad.com')
 INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('104',	'Gage',	'McLorinan',	'gmclorinan6@samsung.com')
INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('105',	'Sigrid',	'Tevlin',	'stevlin7@yale.edu')
  SELECT * FROM DUAL;

/* INSERTING researchers to lecture table*/
INSERT 
  INTO lecture(researcher_id, lecture_ref, l_date, topic, room)
VALUES(106, 15, TO_DATE('12/01/2019 14:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'COMP SCI', 75);

INSERT 
INTO lecture(researcher_id, lecture_ref, l_date, topic, room)
VALUES(106, 16, TO_DATE('22/02/2019 10:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'MEDICINE', 15);

INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(60, 17, TO_DATE('22/03/2019 10:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'HISTORY', 18);

/* /* INSERTING lecturers  to lecture table*/
INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(60, 18, TO_DATE('22/04/2019 12:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'HISTORY', 20);

INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(65, 19, TO_DATE('22/03/2019 08:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'chemistry', 18);

INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(70, 20, TO_DATE('10/04/2019 09:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'maths', 43);



/*INSERT VALUES INTO Student table */
INSERT ALL
 INTO student(student_id,first_name, last_name, course)
 VALUES(100000,'carl', 'maines', 'Computer science')
INTO student(student_id,first_name, last_name, course)
VALUES(100001,'james', 'heek', 'medicine')
INTO student(student_id,first_name, last_name, course)
 VALUES(100003,'grace', 'hail', 'Computer science')
 INTO student(student_id,first_name, last_name, course)
 VALUES(100008,'massy', 'lan', 'law')
 INTO student(student_id,first_name, last_name, course)
 VALUES(100012,'arch', 'ritte', 'history')
 INTO student(student_id,first_name, last_name, course)
 VALUES(100010,'megen', 'lan', 'law')
 INTO student(student_id,first_name, last_name, course)
 VALUES(100022,'gwen', 'main', 'law')
 SELECT * FROM DUAL;

INSERT  
INTO attendance VALUES(100000,15,4);

INSERT 
INTO attendance VALUES(100000,16,2);

INSERT INTO
 attendance VALUES(100001,16,3);

INSERT INTO
 attendance VALUES(100008,16,3);

INSERT 
INTO attendance VALUES(100012,16,5);

INSERT 
INTO attendance VALUES(100012,18,1);

INSERT 
INTO attendance VALUES(100012,17,3);

INSERT 
INTO attendance VALUES(100001,20,3);


SELECT *
FROM attendance;


/* sequence to generate primary keys for papers table */
CREATE sequence pref_sequence
START WITH 11111
INCREMENT BY 1 
MAXVALUE 99999
NOCYCLE;



/* INSERT VALUES IN  papers table */
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'programming future', 'history', '22/JAN/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  ' history of maths', 'finance', '10/MAR/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'internet', 'medical', '22/APR/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'human body', 'law', '22/JAN/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'Business law', 'law', '01/APRIL/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'culture of britian', 'history', '22/MARCH/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'culture of france', 'history', '22/FEB/2019');
INSERT INTO papers(pref, description, topic, p_date)
VALUES(pref_sequence.nextval,  'legal law', 'law', '22/AUG/2019');



/*UPDATING PROJECT_ID FK IN papers table */
UPDATE papers
SET project_id = 326
WHERE pref < = 11114;
UPDATE papers
SET project_id = 327
WHERE topic  = 'law';
UPDATE papers
SET project_id = 328
WHERE project_id  IS NULL;


/* CREATE A TRIGGER ON JOURNAL TABLE */
create or replace TRIGGER trg_before_jour_upd
BEFORE INSERT OR UPDATE
ON journal 
FOR EACH ROW

BEGIN 

CASE :NEW.name   /* BEGIN CASE STATEMENT ON category column to update name column*/
WHEN 'london times' THEN :NEW.rating := 1;
WHEN 'european times' THEN :NEW.rating := 2;
WHEN 'new discoveries' THEN :NEW.rating := 3;
WHEN 'world of ideas' THEN :NEW.rating := 4;
END CASE;
END;

/*Create Sequence for journal primarys keys within journal table */
CREATE SEQUENCE journal_sequence
START WITH 717
INCREMENT BY 1
NOCYCLE;


/*Create Sequence for paper foreign key within journal table */
CREATE SEQUENCE jrpref_sequence
MAXVALUE 11119
INCREMENT BY -1
NOCYCLE;

INSERT INTO
journal(jrid, pref, name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.NEXTVAL, 'london times');

INSERT INTO
journal(jrid, pref,  name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.NEXTVAL, 'london times');

INSERT INTO
journal(jrid, pref,  name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.NEXTVAL, 'european times');

 INSERT INTO
journal(jrid, pref, name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.CURRVAL, 'european times');

INSERT INTO
journal(jrid, pref, name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.NEXTVAL, 'world of ideas');

INSERT INTO
journal(jrid, pref, name) VALUES
(journal_sequence.NEXTVAL, jrpref_sequence.CURRVAL, 'new discoveries');


SELECT *
FROM journal;




/*Insertion of data into expenses table */
INSERT INTO  
 expense VALUES('23/MAR/2019','wages', 'manpower', 123.45,101,326);
INSERT INTO
 expense VALUES('23/FEB/2019','travel', 'misc', 341.33,102, 326);

INSERT 
INTO expense VALUES('21/APR/2019','wages', 'manpower', 533.11, 103, 326);


INSERT
INTO expense VALUES('10/MAR/2019','accommodation', 'misc', 242.12,107, 326);

/*Insertion of data into expenses table */
INSERT INTO  
 expense VALUES('10/FEB/2019','wages', 'manpower', 213.45, 108,  327);
INSERT 
INTO expense VALUES('13/MAR/2019','subsistence', 'misc', 234.12,109,326);

INSERT 
INTO expense VALUES('11/APR/2019','wages', 'manpower', 123.00,108,326);

INSERT 
INTO expense VALUES('11/APR/2019','wages', 'manpower', 546.22,108,326);

/*Inserting additional data */
INSERT 
INTO expense VALUES('21/APR/2019','subsistence', 'misc', 213.22,101,332);

INSERT 
INTO expense VALUES('22/APR/2019','wages', 'manpower', 113.22,102,332);

INSERT 
INTO expense VALUES('22/APR/2019','wages', 'manpower', 113.22,103,333);

/*1 QUERY TO produce list of projects budgets and remaing balance */
SELECT project.project_id,project.budget, NVL(project.budget - SUM(expense.amount),0) AS Balance
FROM project, expense 
WHERE project.project_id =  expense.project_id(+) 
GROUP BY  project.project_id, project.budget
ORDER BY Balance DESC;

/* 2 Query to produce organizations that are involved in projects */
SELECT  B.name, B.p_number, C.project_id
FROM sponsored  A, organization  B, project  C
WHERE B.orgid = A.orgid
AND C.project_id = A.project_id
GROUP BY B.name, B.p_number, C.project_id
ORDER BY b.name;

/* 2 Query to list  researchers that have written on a paper 11114*/
SELECT B.name, D.pref
FROM team_project A, researcher B, papers D
WHERE D.pref = '&input'
AND B.researcher_id = A.researcher_id
AND  A.project_id = D.project_id;



/*3 QUERY to produce a count of papers that are produce by projects that have
ended*/
SELECT A.project_id, COUNT(B.project_id) AS "TOTAL PAPERS"
FROM project A, papers B
WHERE A.end_date is NOT NULL
AND A.project_id = B.project_id
GROUP BY A.project_id
ORDER BY project_id;

/* 5 QUERY to produce projects with papers with their highest rating */
SELECT A.project_id, C.pref, MAX(C.rating)AS maxrating
FROM project A, papers B, journal C
WHERE A.project_id = B.project_id
AND B.pref = C.pref 
GROUP BY A.project_id,C.pref
ORDER BY maxrating DESC;

/*6 QUERY to summarize  project expenses for project id 326 */
SELECT B.category, sum(B.amount) AS TOTALEXPENSES
FROM team_project A, expense B
WHERE A.project_id = '&input' /*request input and join project id 326*/
AND A.project_id = B.project_id
GROUP BY B.category;


/*7 QUERY to count how many guests a researcher have by counting the researcher fk that exist
and performing an outerjoin on the lecture table*/ 
SELECT  A.name, Count(B.researcher_id)AS guestcount
FROM researcher A, lecturer B
WHERE A.researcher_id = B.researcher_id(+)
GROUP BY A.name
ORDER BY guestcount DESC;


/*8 QUERY to allow students to view upcoming researcher lectures */
SELECT A.name, TO_CHAR(l_date,'DD-Mon-YYYY HH24:MI:SS') AS LDATE, B.topic,
B.room
FROM researcher A, lecture B
WHERE A.researcher_id = B.researcher_id
ORDER BY LDATE DESC;

/* 9 QUERY to allow students to view upcoming guest lectures */
SELECT A.first_name, last_name, TO_CHAR(l_date,'DD-Mon-YYYY HH24:MI:SS')AS LDATE, B.topic,
B.room
FROM lecturer A, lecture B
WHERE A.guest_id = B.guest_id
ORDER BY LDATE DESC;

/* 10 QUERY to produce average feedback of a student */
SELECT A.student_id, A.first_name, A.last_name, AVG(B.feedback) AS AVERAGE
FROM student A, attendance B
WHERE A.student_id = B.student_id
GROUP BY A.student_id, A.first_name, A.last_name
ORDER BY A.first_name;



/*11 QUERY to sponsored projects that ended after estimated date  */
SELECT B.project_id, A.description
FROM project A, sponsored B
WHERE A.project_id = B.project_id
AND A.end_date >  A.est_end_date
GROUP BY B.project_id, A.description
ORDER BY A.description;

/* 12 Query for team leadersto produce summary of expenses for
project 327*/
SELECT B.role, C.category, SUM(amount)AS TOTALEXPENSE
FROM team_project B, expense C
WHERE B.project_id = '&input'
AND B.project_id = C.project_id
AND role NOT IN ('team leader')
GROUP BY B.role, C.category
ORDER BY TOTALEXPENSE;

/*13 QUERY to list names of researchers that are team leaders*/
SELECT A.name, B.project_id
FROM researcher A, team_project B
WHERE B.role = 'team leader'
AND A.researcher_id = B.researcher_id
GROUP BY A.name, B.project_id
ORDER BY A.name;




/* 1 CREATE VIEW FOR projects that are funded only by the university */
CREATE VIEW 
deanview(projid,description, budget)
AS 
SELECT project_id, description, budget
FROM project A
WHERE A.project_id NOT IN
(Select project_id
FROM sponsored);

/* 2 CREATE VIEW for researchers to keep track of ratings of lecturers who
have attended lectures*/
CREATE VIEW
admin(firstname, lastname, email, rating)
AS
SELECT A.first_name, A.last_name, A.email, C.feedback
FROM lecturer A, lecture B, attendance C
WHERE A.guest_id = B.guest_id
AND B.lecture_ref = C.lecture_ref;


DROP TABLE sponsored;

DROP TABLE organization;

DROP TABLE team_project;

DROP TABLE attendance;

DROP TABLE student;

DROP TABLE lecture;

DROP TABLE lecturer;

DROP TABLE expense;

DROP TABLE journal;

DROP TABLE papers;

DROP TABLE project;

SELECT *
FROM journal;









