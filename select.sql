# 1.查询同时存在1课程和2课程的情况

select a.* ,b.score [1课程],c.score [2课程] 
from student a ,student_course b, student_course c 
where a.id = b.id and  a.id = c.id and b.courseld= '1' and c.courseld='2'

# 2.查询同时存在1课程和2课程的情况

select a.* ,b.score [1课程],c.score [2课程] 
from student a ,student_course b, student_course c 
where a.id = b.id and  a.id = c.id and b.courseld= '1' and c.courseld='2'

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

select a.id ,a.name ,cast(avg(b.score) 
as decimal(18,2)) avg_score 
from student a ,student_course b 
where a.id = b.id 
group by a.id ,a.name 
having cast(avg(b.score) as decimal(18,2)) >= 60
order by a.id

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句

select a.id ,a.name ,isnull(cast(avg(b.score)
as decimal(18,2)),0) avg_score 
from student a left 
join student_course b on a.id = b.id 
group by a.id , a.name 
having isnull(cast(avg(b.score) as decimal(18,2)),0)  < 60
order by a.id

# 5.查询所有有成绩的SQL

select a.id[学生编号], a.name学生姓名[], 
count(b.courseld) 选课总数, sum(score) [所有课程总成绩] 
from student a , student_course b 
where a.id = b.id  
group by a.id , a.name 
order by a.id

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息

select student.* 
from  student , student_course 
where student.id = student_course.id and student_course.courseld = '1' and exists
                  (Select 1 
                    from student_course student_course_2 
                    where student_course_2.id = student_course.id 
                    and student_course_2.courseld= '2' 
                    order by student.id）

# 7.检索1课程分数小于60，按分数降序排列的学生信息

select student.*, student_course.courseld  student_course.score 
from student , student_course 
where student.id = student_course.id and student_course.score < 60 and student_course.courseld = '1' 
order by student_course.score desc

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

select m.courseld , m.name , cast(avg(n.score) 
as decimal(18,2)) avg_score 
from course m ,  student_course n 
where m.courseld = n.courseld 
group by m.courseld , m.name  
order by avg_score desc, m.courseld asc

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数

select name ,score 
from student ,  student_course , course 
where student_course .id = student.id and student_course.courseld = course.courseld and course.name = '数学' and score <60
