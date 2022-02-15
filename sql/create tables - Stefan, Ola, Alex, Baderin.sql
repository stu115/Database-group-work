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
s_date DATE,
est_end_date DATE,
end_date DATE);

/* ADD CONSTRAINT */
ALTER TABLE project
ADD CONSTRAINT ck_est_end_date
CHECK(est_end_date > s_date)
ADD CONSTRAINT ck_end_date
CHECK(end_date > est_end_date);

/* CREATE TEAM PROJECT TABLE */
CREATE TABLE team_project
(role VARCHAR2(12) constraint nn_team_project_role NOT NULL,
project_id NUMBER(4),
researcher_id VARCHAR2(5),
CONSTRAINT fk1_team_project_project_id FOREIGN KEY (project_id) REFERENCES
project(project_id),
CONSTRAINT fk2_team_project_researcher_id  FOREIGN KEY (researcher_id) REFERENCES
researcher(researcher_id),
CONSTRAINT fk1fk2 UNIQUE(project_id, researcher_id)
);

/* CREATE ORGANIZATION TABLE */
CREATE TABLE organization 
( orgid NUMBER(4) constraint pk_organization_orgid PRIMARY KEY,
name VARCHAR2(50) constraint nn_organization_name NOT NULL,
p_number VARCHAR(14) constraint unique_organization_p_number UNIQUE,
location VARCHAR(20) constraint nn_organization_location NOT NULL);

/* Create Sponsored table*/
(orgid NUMBER(4),
project_id NUMBER (4),
 CONSTRAINT fk_sponsored_orgid FOREIGN KEY (orgid)
 REFERENCES organization(orgid),
 CONSTRAINT fk_sponsored_project_id  FOREIGN KEY (project_id)
 REFERENCES project(project_id),
 CONSTRAINT orgpro UNIQUE (orgid, project_id));

/* Create expense table*/
CREATE TABLE expense
(e_date DATE constraint nn_expense_e_date NOT NULL,
description VARCHAR2(15) constraint nn_expense_description NOT NULL,
category VARCHAR2(20),
amount NUMBER(5,2),
researcher_id VARCHAR2(5),
project_id NUMBER(4),
constraint fk_expense_researcher_id FOREIGN KEY (researcher_id) REFERENCES 
researcher(researcher_id),
constraint fk_expense_project_id FOREIGN KEY (project_id) REFERENCES
project(project_id));

/* ADD CHECK CONSTRAINTS TO EXPENSE TABLE*/
ALTER TABLE expense
ADD CONSTRAINT check_category
CHECK(category = 'misc' or category = 'manpower')
ADD CONSTRAINT check_description
CHECK( description IN ('travel','subsistence', 'accommodation','wages'))
ADD CONSTRAINT check_amount 
CHECK(amount BETWEEN 1 AND 2000);

/* ADD UNIQUECONSTRAINTS TO FK IN EXPENSE TABLE*/
ALTER TABLE expense
ADD CONSTRAINT respr
UNIQUE (researcher_id, project_id);

/* Creation of Lecturer tables with constraints */
CREATE TABLE lecturer 
(guest_id  NUMBER(4) constraint pk_guest_lecturer_guest_id PRIMARY KEY,
first_name VARCHAR2(20) constraint nn_guest_lecturer_first_name NOT NULL,
last_name VARCHAR2(20) constraint nn_lecturer_last_name NOT NULL, 
email VARCHAR2(50),
researcher_id VARCHAR2(5),
CONSTRAINT fk_lecturer_researcher_id FOREIGN KEY (researcher_id) REFERENCES
researcher(researcher_id));

/* Create table with papers */
CREATE TABLE papers(
    pref NUMBER(5) constraint pk_papers_pref PRIMARY KEY,
    description VARCHAR2(50),
    Topic VARCHAR2(25) 
CONSTRAINT ck_papers_topic CHECK( topic IN ('history', 'finance', 'medical', 'law', 'IT')),
    p_date DATE DEFAULT SYSDATE,
     Project_id NUMBER(4),
     constraint fk_papers_project_id FOREIGN KEY (project_id) REFERENCES
     project(project_id));

/* Create academics tables */
CREATE TABLE academics(
    acadno NUMBER(4) constraint pk_academics_acadno PRIMARY KEY,
    title VARCHAR2(3) CONSTRAINT ck_academics_title CHECK( title IN ( 'MR', 'MS','MRS', 'DR')),
    first_name VARCHAR2(20) constraint nn_academics_first_name NOT NULL, 
    last_name VARCHAR2(20) constraint nn_academics_last_name NOT NULL;
    
    /* Create journal table */
    CREATE TABLE journal
    (name VARCHAR2(20) constraint nn_journal_name NOT NULL,
    rating NUMBER(1),
    category VARCHAR2(30),
    pref NUMBER(5),
    acadno NUMBER(4),
    constraint fk_journal_pref FOREIGN KEY (pref) REFERENCES
    papers(pref),
    constraint fk_journal_acadno FOREIGN KEY (acadno) REFERENCES
    academics(acadno),
    CONSTRAINT acapap UNIQUE (pref, acadno));


/* ADD CONSTRAINT TO JOURNAL table */
ALTER TABLE journal
ADD CONSTRAINT ck__category
CHECK(category in('accounting', 'computer science', 'law', 'medicine', 'history'))
ADD CONSTRAINT ck_rating
CHECK(rating <= 5 );

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





