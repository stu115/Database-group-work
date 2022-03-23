

/* A query to check details of the lecture table.*/

SELECT * 

FROM lecture

/* Create a query to check the dates of a lecture and the researcher who will be giving the lecture. The dates
will be listed in date order.*/

SELECT researcher_id,lecture_ref,l_date

FROM lecture

GROUP BY lecture_ref, researcher_id,l_date
ORDER BY l_date

/* Creation of a query for the researcher to see the estimated end date of a project. Allows them input their researcher
id and project id to see how long they have to complete the project they are working on.*/

SELECT project_id,description,end_date,estimated end_date  

FROM project
WHERE researcher_id = '&Researcher ID' 
AND project_id = '&Project ID'
 
