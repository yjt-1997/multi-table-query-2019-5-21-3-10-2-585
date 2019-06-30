# 1.查询同时存在1课程和2课程的情况
//题目意思没看懂...
# 2.查询同时存在1课程和2课程的情况

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT
	s.id,
	s. NAME,
	avg(c.score)
FROM
	student s
JOIN student_course c ON s.id = c.studentId
GROUP BY
	s.id
HAVING
	AVG(c.score) >= 60

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
SELECT
	*
FROM
	student
WHERE
	id NOT IN (
		SELECT DISTINCT
			(student_course.studentId)
		FROM
			student_course
	)

# 5.查询所有有成绩的SQL
SELECT
	*
FROM
	student
WHERE
	id IN (
		SELECT DISTINCT
			(student_course.studentId)
		FROM
			student_course
	)
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
SELECT
	*
FROM
	student
WHERE
	id IN (
		SELECT
			studentId
		FROM
			student_course
		WHERE
			courseId IN (1, 2)
		GROUP BY
			studentId
		HAVING
			COUNT(*) >= 2
	)
# 7.检索1课程分数小于60，按分数降序排列的学生信息
SELECT
	*
FROM
	student s,
	student_course c
WHERE
	s.id = c.studentId
AND c.courseId = 1
AND c.score < 60
ORDER BY
	c.score DESC
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT
	courseId,
	AVG(score)
FROM
	student_course
GROUP BY
	courseId
ORDER BY
	AVG(score) DESC,
	courseId
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT
	s. NAME,
	sc.score
FROM
	student s,
	student_course sc,
	course c
WHERE
	c. NAME = '数学'
AND c.id = sc.courseId
AND sc.score < 60
AND sc.studentId = s.id