-- Query 6:
--From the students table, write a SQL query to interchange the adjacent student names.
--Note: If there are no adjacent student then the student name should stay the same.

--Table Structure:
drop table students;
create table students
(
id int primary key,
student_name varchar(50) not null
);
insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

select * from students;

--Solution:
SELECT
    id,
    student_name,
    CASE
        WHEN id % 2 <> 0 THEN LEAD(student_name, 1, student_name) OVER (ORDER BY id)
        WHEN id % 2 = 0 THEN LAG(student_name) OVER (ORDER BY id)
    END AS new_student_name
FROM
    students;

/*In summary, the new_student_name column will contain 
the value of the next student_name when id is odd 
and the value of the previous student_name when id is even. 
The LEAD and LAG window functions are used to access 
values from subsequent or preceding rows in the result set, respectively,
based on the ordering specified by ORDER BY id*/