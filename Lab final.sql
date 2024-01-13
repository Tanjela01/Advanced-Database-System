1.
   Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

   Insert data into departments table
INSERT INTO departments (department_id, department_name) VALUES (1, 'Computer Science');
INSERT INTO departments (department_id, department_name) VALUES (2, 'Electrical Engineering');
INSERT INTO departments (department_id, department_name) VALUES (3, 'Mathematics');

   Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

   Insert data into students table
INSERT INTO students (student_id, student_name, date_of_birth, department_id) VALUES (1, 'John Doe', '1990-05-15', 1);
INSERT INTO students (student_id, student_name, date_of_birth, department_id) VALUES (2, 'Jane Smith', '1992-08-20', 2);
INSERT INTO students (student_id, student_name, date_of_birth, department_id) VALUES (3, 'Bob Johnson', '1991-03-10', 3);

   Create courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    department_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

   Insert data into courses table
INSERT INTO courses (course_id, course_name, department_id, credits) VALUES (1, 'Introduction to Programming', 1, 3);
INSERT INTO courses (course_id, course_name, department_id, credits) VALUES (2, 'Circuit Analysis', 2, 4);
INSERT INTO courses (course_id, course_name, department_id, credits) VALUES (3, 'Calculus I', 3, 3);

2.
 a)
-- Declare necessary variables
DECLARE
    max_course_count NUMBER;
    max_dept_id departments.department_id%TYPE;
    
    -- Cursor to fetch department-wise course counts
    CURSOR dept_course_count_cursor IS
        SELECT department_id, COUNT(*) AS course_count
        FROM courses
        GROUP BY department_id;

BEGIN
    -- Initialize variables
    max_course_count := 0;
    
    -- Loop through the cursor and find the department with the maximum number of courses
    FOR dept_rec IN dept_course_count_cursor
    LOOP
        IF dept_rec.course_count > max_course_count THEN
            max_course_count := dept_rec.course_count;
            max_dept_id := dept_rec.department_id;
        END IF;
    END LOOP;

    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Department with the maximum number of courses:');
    DBMS_OUTPUT.PUT_LINE('Department ID: ' || max_dept_id);
    DBMS_OUTPUT.PUT_LINE('Number of Courses: ' || max_course_count);
    
END;
/
b)
-- Declare necessary variables
DECLARE
    student_id students.student_id%TYPE;
    student_name students.student_name%TYPE;
    
    -- Cursor to fetch students in CSE department taking at least one course of 4 credits
    CURSOR cse_students_cursor IS
        SELECT s.student_id, s.student_name
        FROM students s
        JOIN courses c ON s.department_id = c.department_id
        WHERE s.department_id = 1 -- Assuming CSE department ID is 1
        AND c.credits = 4;

BEGIN
    -- Open and loop through the cursor
    OPEN cse_students_cursor;
    
    -- Fetch and output the result
    DBMS_OUTPUT.PUT_LINE('Students in CSE department taking at least one course of 4 credits:');
    LOOP
        FETCH cse_students_cursor INTO student_id, student_name;
        EXIT WHEN cse_students_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || student_id || ', Name: ' || student_name);
    END LOOP;

    -- Close the cursor
    CLOSE cse_students_cursor;

END;
/
c)
-- Declare necessary variables
DECLARE
    course_id courses.course_id%TYPE;
    course_name courses.course_name%TYPE;
    course_credits courses.credits%TYPE;
    
    -- Cursor to fetch course details of EEE department
    CURSOR eee_courses_cursor IS
        SELECT course_id, course_name, credits
        FROM courses
        WHERE department_id = 3; -- Assuming EEE department ID is 3

BEGIN
    -- Open and loop through the cursor
    OPEN eee_courses_cursor;
    
    -- Fetch and output the result
    DBMS_OUTPUT.PUT_LINE('Course details of EEE department:');
    LOOP
        FETCH eee_courses_cursor INTO course_id, course_name, course_credits;
        EXIT WHEN eee_courses_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Course ID: ' || course_id || ', Name: ' || course_name || ', Credits: ' || course_credits);
    END LOOP;

    -- Close the cursor
    CLOSE eee_courses_cursor;

END;
/

d)
-- Declare necessary variables
DECLARE
    course_id courses.course_id%TYPE;
    course_name courses.course_name%TYPE;
    course_credits courses.credits%TYPE;
    
    -- Variables to store the minimum credit
    min_credit NUMBER;
    
    -- Cursor to fetch courses with the minimum credit
    CURSOR min_credit_courses_cursor IS
        SELECT course_id, course_name, credits
        FROM courses
        WHERE credits = min_credit;

BEGIN
    -- Find the minimum credit
    SELECT MIN(credits) INTO min_credit FROM courses;
    
    -- Open and loop through the cursor
    OPEN min_credit_courses_cursor;
    
    -- Fetch and output the result
    DBMS_OUTPUT.PUT_LINE('Courses having the minimum credit:');
    LOOP
        FETCH min_credit_courses_cursor INTO course_id, course_name, course_credits;
        EXIT WHEN min_credit_courses_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Course ID: ' || course_id || ', Name: ' || course_name || ', Credits: ' || course_credits);
    END LOOP;

    -- Close the cursor
    CLOSE min_credit_courses_cursor;

END;
/
e)
-- Declare necessary variables
DECLARE
    course_id courses.course_id%TYPE;
    course_name courses.course_name%TYPE;
    course_credits courses.credits%TYPE;
    
    -- Variables to store the minimum student count
    min_student_count NUMBER;
    min_student_course_id courses.course_id%TYPE;
    
    -- Cursor to fetch courses and their student counts
    CURSOR course_student_count_cursor IS
        SELECT c.course_id, c.course_name, c.credits, COUNT(sc.student_id) AS student_count
        FROM courses c
        LEFT JOIN students_courses sc ON c.course_id = sc.course_id
        GROUP BY c.course_id, c.course_name, c.credits;

BEGIN
    -- Find the course with the minimum student count
    SELECT MIN(student_count), MIN(course_id) INTO min_student_count, min_student_course_id
    FROM (
        SELECT COUNT(student_id) AS student_count, course_id
        FROM students_courses
        GROUP BY course_id
    );
    
    -- Open and loop through the cursor
    OPEN course_student_count_cursor;
    
    -- Fetch and output the result
    DBMS_OUTPUT.PUT_LINE('Course with the minimum number of students:');
    LOOP
        FETCH course_student_count_cursor INTO course_id, course_name, course_credits, min_student_count;
        EXIT WHEN course_student_count_cursor%NOTFOUND;
        
        IF min_student_count = 0 OR (min_student_count > 0 AND course_id = min_student_course_id) THEN
            DBMS_OUTPUT.PUT_LINE('Course ID: ' || course_id || ', Name: ' || course_name || ', Credits: ' || course_credits);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE course_student_count_cursor;

END;
/
