-- Query 8:
--From the following 3 tables (event_category, physician_speciality, patient_treatment),--
--write a SQL query to get the histogram of specialities of the unique physicians
--who have done the procedures but never did prescribe anything.

--Table Structure:
--drop table event_category;
create table event_category
(
  event_name varchar(50),
  category varchar(100)
);

--drop table physician_speciality;
create table physician_speciality
(
  physician_id int,
  speciality varchar(50)
);

--drop table patient_treatment;
create table patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);


insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');


insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');


insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);


select * from patient_treatment;
select * from event_category;
select * from physician_speciality;


-- Solution:
select ps.speciality, count(1) as speciality_count
from patient_treatment pt
join event_category ec on ec.event_name = pt.event_name
join physician_speciality ps on ps.physician_id = pt.physician_id
where ec.category = 'Procedure'
and pt.physician_id not in (select pt2.physician_id
							from patient_treatment pt2
							join event_category ec on ec.event_name = pt2.event_name
							where ec.category in ('Prescription'))
group by ps.speciality;


--Another solution using left join
SELECT ps.speciality, COUNT(1) AS speciality_count
FROM physician_speciality ps
JOIN patient_treatment pt ON ps.physician_id = pt.physician_id
JOIN event_category ec ON ec.event_name = pt.event_name
LEFT JOIN (
    SELECT DISTINCT pt2.physician_id
    FROM patient_treatment pt2
    JOIN event_category ec2 ON ec2.event_name = pt2.event_name
    WHERE ec2.category = 'Prescription'
) excluded_physicians ON ps.physician_id = excluded_physicians.physician_id
WHERE ec.category = 'Procedure'
  AND excluded_physicians.physician_id IS NULL
GROUP BY ps.speciality