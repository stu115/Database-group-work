/* create sequence project primary key sequence 
Insertion of data within the project table */

CREATE sequence project_id_sequence
INCREMENT BY 1 
START WITH 325
MAXVALUE 9999
NOCYCLE;

SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';


/*Insertion into coulmns  */
INSERT INTO project
VALUES(project_id_sequence.nextval, 'programming', '01/JAN/2019', '15/JAN/2019',
'18/JAN/2019', 450.31);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'new law', '15/JAN/2019', '01/FEB/2019',
'05/FEB/2019', 721.22);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'uk history', '10/FEB/2019', '20/FEB/2019',
'18/FEB/2019', 335.12);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'chemistry', TO_DATE('11/FEB/2019', 
'DD/MON/YYYY'), TO_DATE('11/MAR/2019', 'DD/MON/YYYY'),  TO_DATE('20/MAR/2019', 'DD/MON/YYYY'), 
865.21);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'Technology', '05/MAR/2019', '31/MAR/2019',
'15/MAR/2019',
 1001.00);

/*Insertion in all coulmns  */
INSERT INTO project
VALUES(project_id_sequence.nextval, 'programming', '01/JAN/2019', '15/JAN/2019',
'18/JAN/2019', 450.31);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'new law', '15/JAN/2019', '01/FEB/2019',
'05/FEB/2019', 721.22);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'uk history', '10/FEB/2019', '20/FEB/2019',
'18/FEB/2019', 335.12);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'chemistry', TO_DATE('11/FEB/2019', 
'DD/MON/YYYY'), TO_DATE('11/MAR/2019', 'DD/MON/YYYY'),  TO_DATE('20/MAR/2019', 'DD/MON/YYYY'), 
865.21);
INSERT INTO project
VALUES(project_id_sequence.nextval, 'Technology', '05/MAR/2019', '31/MAR/2019',
'15/MAR/2019',
 1001.00);


 /* INSERTION IN SPECIFIED project columns */
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'economics', '05/MAR/2019', '20/APR/2019', 821.00);
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'info systems', '21/FEB/2019', '31/MAR/2019', 2000.00);
INSERT INTO project(project_id, description, s_date, est_end_date, budget)
VALUES(project_id_sequence.nextval, 'mathematics', '11/MAR/2019', '01/APR/2019', 5676.00);

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
VALUES(5033, 326)
INTO sponsored 
VALUES(5033, 327)
INTO sponsored 
VALUES(5033, 341)
INTO sponsored 
VALUES(5034, 339)
INTO sponsored 
VALUES(5035, 339)
INTO sponsored 
VALUES(5037, 339)
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
INTO team_project VALUES('Team leader', 326, 513)
INTO team_project VALUES('Team leader', 327, 513)
INTO team_project VALUES('researcher', 329, 514)
INTO team_project VALUES('Administrator', 329, 515)
INTO team_project VALUES('Administrator', 329, 516)
INTO team_project VALUES('Team leader', 341, 518)
INTO team_project VALUES('researcher', 341, 519)
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
  SELECT guest_id.nextval
  INTO :new.guest_id
  FROM dual;
END;

INSERT 
INTO lecturer(researcher_id,first_name,  last_name, email)
VALUES ('513', 'Kimberlyn','Mulvy','kmulvy0@bloglovin.com');

INSERT ALL
INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('513',	'Kimberlyn',	'Mulvy',	'kmulvy0@bloglovin.com')
INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('513',	'Jemmy',	'Wigzell',	'jwigzell1@oaic.gov.au')
 INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('513',	'Jeth',	'Wollacott',	'jwollacott2@zdnet.com')
 INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('520',	'Dannie',	'Meins',	'dmeins3@spiegel.de')
INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES ('520',	'Marthe',	'Eidelman',	'meidelman4@princeton.edu')
 INTO LECTURER(researcher_id, first_name, last_name, email)
 VALUES('521',	'Dmitri',	'Leftly',	'dleftly5@typepad.com')
 INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('521',	'Gage',	'McLorinan',	'gmclorinan6@samsung.com')
INTO LECTURER(researcher_id, first_name, last_name, email)
VALUES ('517',	'Sigrid',	'Tevlin',	'stevlin7@yale.edu')
  SELECT * FROM DUAL;

INSERT 
  INTO lecture(researcher_id, lecture_ref, l_date, topic, room)
VALUES(514, 105, TO_DATE('12/01/2019 14:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'COMP SCI', 75);

INSERT 
INTO lecture(researcher_id, lecture_ref, l_date, topic, room)
VALUES(514, 110, TO_DATE('22/02/2019 10:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'MEDICINE', 15);

INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(42, 220, TO_DATE('22/03/2019 10:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'HISTORY', 18);

INSERT
INTO lecture(guest_id, lecture_ref, l_date, topic, room)
VALUES(42, 115, TO_DATE('22/06/2019 10:08:25', 'DD/MM/YYYY HH24:MI:SS'), 'HISTORY', 20);

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
INTO attendance VALUES(100000,105,4);

INSERT 
INTO attendance VALUES(100000,110,2);

INSERT INTO
INTO attendance VALUES(100001,220,3);

INSERT INTO
INTO attendance VALUES(100008,220,3);

INSERT 
INTO attendance VALUES(100012,220,5);

INSERT 
INTO attendance VALUES(100012,115,1);

SELECT *
FROM attendance;

/* Creating a sequence to generate primary keys for academics table */
CREATE sequence acad_no_sequence
INCREMENT BY 5
START WITH 850
MAXVALUE 9999
NOCYCLE;

/* INSERT INTO academics table  */
INSERT 
INTO academics(acadno, title, first_name, last_name)
VALUES(acad_no_sequence.nextval, 'MR', 'harry', 'thomas');

INSERT
INTO academics
VALUES(acad_no_sequence.nextval,'MR', 'thomas', 'matrix');

INSERT INTO academics
VALUES(acad_no_sequence.nextval,'MS', 'mandy', 'thomas');

INSERT INTO  academics
VALUES(acad_no_sequence.nextval, 'MR', 'patrick', 'loose');

INSERT INTO academics 
VALUES(acad_no_sequence.nextval, 'DR', 'tri', 'rich');

INSERT INTO academics 
VALUES(acad_no_sequence.nextval, 'MRS', 'mand', 'kd');


/ *sequence to generate primary keys for papers table */
CREATE sequence pref_sequence
INCREMENT BY 1 
START WITH 11111
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

/* CREATE A TRIGGER ON JOURNAL TABLE */
create or replace TRIGGER trg_before_jour_upd
BEFORE INSERT OR UPDATE
ON journal 
FOR EACH ROW

BEGIN 

CASE :NEW.category   /* BEGIN CASE STATEMENT ON category column to update name column*/
WHEN 'accounting' THEN :NEW.name := 'finance times';
WHEN 'law' THEN :NEW.name := 'world law';
WHEN 'computer science' THEN :NEW.name := 'IT prof';
WHEN 'medicine' THEN :NEW.name := 'doctors';
WHEN 'history' THEN :NEW.name := 'World history';
END CASE;
END;

/*Create Sequence for acaedmics foreign key within journal table */
CREATE SEQUENCE jraca_sequence
MAXVALUE 885
INCREMENT BY -5
NOCYCLE;

/*Create Sequence for paper foreign key within journal table */
CREATE SEQUENCE jrpref_sequence
MAXVALUE 11117
INCREMENT BY -1
NOCYCLE;

INSERT INTO
journal(acadno, pref, category, rating) VALUES
(jraca_sequence.NEXTVAL, jrpref_sequence.NEXTVAL, 'accounting', 5);

INSERT INTO
journal(acadno, pref, category, rating) VALUES
(jraca_sequence.CURRVAL, jrpref_sequence.NEXTVAL, 'law', 4);

INSERT INTO
journal(acadno, pref, category, rating) VALUES
(jraca_sequence.CURRVAL, jrpref_sequence.NEXTVAL, 'accounting', 3);

 INSERT INTO
journal(acadno, pref, category, rating) VALUES
(jraca_sequence.NEXTVAL, jrpref_sequence.CURRVAL, 'medicine', 2);

INSERT INTO
journal(acadno, pref, category, rating) VALUES
(jraca_sequence.NEXTVAL, jrpref_sequence.CURRVAL, 'medicine', 2);

SELECT *
FROM journal;

/*Create Sequence for foreign key within papers table */
CREATE SEQUENCE papfk_sequence
MAXVALUE 344
INCREMENT BY -1
NOCYCLE;

/*Updating  foreign keys column in papers table*/
UPDATE papers
SET project_id = papfk_sequence.NEXTVAL
WHERE topic = 'law';


/* CREATE A researcher sequence for FK in expense table */

CREATE SEQUENCE exp_fk
MAXVALUE 521  /* Last researcher PK in researcher table */
INCREMENT BY -1
NOCYCLE;

/* CREATE A sequence for project FK in expense table */
CREATE SEQUENCE exp_fk2
MAXVALUE 344    /* Last project PK in project table */
INCREMENT BY -1
NOCYCLE;

/*Insertion of data into expenses table */
INSERT INTO  
 expense VALUES('23/MAR/2019','wages', 'manpower', 123.45,exp_fk.NEXTVAL,exp_fk2.NEXTVAL);
INSERT INTO
INTO expense VALUES('23/FEB/2019','travel', 'misc', 341.33,exp_fk.CURRVAL,exp_fk2.NEXTVAL);

INSERT 
INTO expense VALUES('21/APR/2019','wages', 'manpower', 533.11,exp_fk.NEXTVAL,exp_fk2.NEXTVAL);


INSERT
INTO expense VALUES('10/MAR/2019','travel', 'misc', 242.12,exp_fk.NEXTVAL, exp_fk2.NEXTVAL);

SELECT *
FROM expense;

