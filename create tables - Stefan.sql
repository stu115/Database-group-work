
/*Creation of the Lecture table */

CREATE TABLE Lecture
(researcher_id VARCHAR2(5) CONSTRAINT fk_Lecture_reseacher_id REFERENCES researcher(researcher_id), 
guest_id NUMBER(4) CONSTRAINT fk_lecture_guest_ID REFERENCES lecturer(guest_id),
Lecture_ref NUMBER(4) CONSTRAINT pk_lecture_Lecture_ID Primary key,
L_Date DATE CONSTRAINT nn_lecture_L_Date NOT NULL,
Topic VARCHAR2(15) CONSTRAINT nn_Lecture_Topic NOT NULL)
Room ;

/*Creation of the Attendance table*/

CREATE TABLE Attendance
(Lecture_ref NUMBER(4) CONSTRAINT fk_Attendance_Lectue_ref REFERENCES Lecture(Leture_ref),
Student_id NUMBER(6) CONSTRAINT fk_Attendance_Student_id REFERENCES Student(Student_id),
Feedback NUMBER(1) CONSTRAINT nn_Attendance_Feedback NOT NULL);

/*Creation of the Student table*/

CREATE TABLE Student 
(Student_ID NUMBER(6) Constraint pk_lecture_Student_ID PRIMARY KEY,
First_Name VARCHAR2(15) CONSTRAINT nn_student_name NOT NULL,
Last_name VARCHAR2(15) CONSTRAINT nn_Student_last name NOT NULL,
Course VARCHAR2(15) CONSTRAINT nn_Student_Course NOT NULL);

