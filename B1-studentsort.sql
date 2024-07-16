-- there are table class, mark, student, subject

CREATE TABLE Class(
    classID   INT AUTO_INCREMENT PRIMARY KEY,
    className VARCHAR(60) NOT NULL,
    startDate DATE        NOT NULL,
    status    BIT
);
CREATE TABLE Student(
    studentId   INT AUTO_INCREMENT PRIMARY KEY,
    studentName VARCHAR(255) NOT NULL,
    address     VARCHAR(255),
    phone       VARCHAR(255),
    status      BIT,
    classId     INT,
    FOREIGN KEY (classId) REFERENCES Class(classID)
);
CREATE TABLE Subject(
    subId   INT AUTO_INCREMENT PRIMARY KEY,
    subName VARCHAR(30) NOT NULL,
    credit  INT DEFAULT 1 CHECK(credit >= 1),
    status  BIT           DEFAULT 1
);
CREATE TABLE Mark(
    markId    INT AUTO_INCREMENT PRIMARY KEY,
    subjectId INT,
    FOREIGN KEY (subjectId) REFERENCES Subject(subId),
    studentId INT,
    FOREIGN KEY (studentId) REFERENCES Student (studentId),
    mark DOUBLE DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    examTimes INT DEFAULT 1  
);

insert into Class (className,startDate,status) values 
('12A1','2020-01-15',0),
('12A2','2020-01-15',1),
('12A3','2020-01-15',0),
('12A4','2020-01-15',1)
;

INSERT INTO Student (studentName, address, phone, status, classId) VALUES
('John Doe', '123 Main St', '555-1234', 1, 1),
('Jane Smith', '456 Elm St', '555-5678', 1, 2),
('Alice Johnson', '789 Oak St', '555-9101', 0, 3),
('Bob Brown', '101 Maple St', '555-1122', 1, 4);
-- add more
INSERT INTO Student (studentName, address, phone, status, classId) VALUES
('Hồ Da Hùng', 'Hà Nội', '098765431', 1, 1),
('Phan Văn Giang', 'Đà nẵng', '0967811255', 1, 1),
('Dương Mỹ Huyền', 'Hà Nội', '0385546611', 0, 1);

INSERT INTO Subject (subName, credit, status) VALUES
('Algebra', 3, 1),
('Biology', 4, 1),
('World History', 2, 1),
('English Literature', 3, 1);

INSERT INTO Mark (subjectId, studentId, mark, examTimes) VALUES
(1, 1, 85.5, 1),
(2, 2, 90.0, 1),
(3, 3, 75.0, 2),
(4, 4, 88.0, 1),
(1, 2, 78.5, 1),
(2, 3, 82.0, 1),
(3, 4, 67.0, 1),
(4, 1, 92.0, 1);


select * from class;

select * from Mark;

-- find column student in student
SELECT studentName … FROM Student; 

-- find every student in student where status = 1;
select * from student where status = 1;


-- show list class with z-a
select * from class 
order by class.className desc;

-- show list student with "hanoi" address
select * from student
where student.address = 'Hà Nội';

-- show list student in class c1
select * from student
join class on class.classID = student.classId
where class.className like '12A1';
-- show list student in class c2
select * from student
join class on class.classID = student.classId
where class.className = '12A1';

-- show list subject has credit > 2
select * from Subject
where subject.credit > 2;

-- show list student with phone start 09
select * from student 
where student.phone like '09%';

-- session 04

-- show list number student group by address
select student.address, count(student.studentName) from Student
group by student.address;

-- show list subject has biggest mark
select subject.subName, max(mark.mark) from subject
join mark on subject.subId = mark.subjectId
group by subject.subName;

-- show avg mark from every student
select student.studentName, avg(mark.mark) from mark
join student on student.studentId = mark.studentId
group by mark.studentId;

-- show avg mark from every student and in the condition which mark > 80
select student.studentName, avg(mark.mark) from mark
join student on student.studentId = mark.studentId
group by mark.studentId
having avg(mark.mark) >=80 
;

-- show student who has biggest avg mark
select student.studentName, max(avg(mark.mark)) from mark
join student on student.studentId = mark.studentId
group by mark.studentId;

-- Show student who has the biggest average mark
SELECT studentName, avgMark
FROM (
    SELECT student.studentName, AVG(mark.mark) AS avgMark
    FROM Mark
    JOIN Student ON Student.studentId = Mark.studentId
    GROUP BY Student.studentId
) AS studentAverages
ORDER BY avgMark DESC
LIMIT 1;

-- show student infor and avg of every student. Sort desc
select student.studentId, student.studentName, student.address, student.phone, student.status, student.classId, avg(mark.mark)  as avgMark from mark
join student on student.studentId = mark.studentId
group by mark.studentId
order by avgMark desc;
