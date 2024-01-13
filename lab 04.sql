1.
DECLARE
   TYPE IntArray IS TABLE OF INTEGER INDEX BY PLS_INTEGER;
   numbers IntArray;
BEGIN
   -- Initialize the array
   numbers(1) := 3;
   numbers(2) := 10;
   numbers(3) := 56;
   numbers(4) := 28;
   numbers(5) := 7;
   numbers(6) := 7;
   numbers(7) := 6;
   numbers(8) := 89;
   numbers(9) := 100;
   numbers(10) := 2;

   -- Print even numbers
   DBMS_OUTPUT.PUT_LINE('Even numbers: ');
   FOR i IN numbers.FIRST..numbers.LAST LOOP
      IF MOD(numbers(i), 2) = 0 THEN
         DBMS_OUTPUT.PUT(numbers(i) || ', ');
      END IF;
   END LOOP;

   -- Print odd numbers
   DBMS_OUTPUT.PUT_LINE('Odd numbers: ');
   FOR i IN numbers.FIRST..numbers.LAST LOOP
      IF MOD(numbers(i), 2) != 0 THEN
         DBMS_OUTPUT.PUT(numbers(i) || ', ');
      END IF;
   END LOOP;
END;
/
2.
DECLARE
   TYPE NameArray IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
   TYPE MarksArray IS TABLE OF INTEGER INDEX BY PLS_INTEGER;

   students NameArray;
   quiz1 MarksArray;
   quiz2 MarksArray;
   bestQuiz MarksArray;
BEGIN
   -- Initialize arrays
   students(1) := 'Student1';
   students(2) := 'Student2';
   students(3) := 'Student3';
   students(4) := 'Student4';
   students(5) := 'Student5';

   quiz1(1) := 90;
   quiz1(2) := 85;
   quiz1(3) := 78;
   quiz1(4) := 92;
   quiz1(5) := 88;

   quiz2(1) := 95;
   quiz2(2) := 88;
   quiz2(3) := 82;
   quiz2(4) := 94;
   quiz2(5) := 89;

   -- Find the best quiz for each student
   FOR i IN students.FIRST..students.LAST LOOP
      IF quiz1(i) > quiz2(i) THEN
         bestQuiz(i) := quiz1(i);
      ELSE
         bestQuiz(i) := quiz2(i);
      END IF;
      DBMS_OUTPUT.PUT_LINE(students(i) || ': Best Quiz - ' || bestQuiz(i));
   END LOOP;
END;
/
3.
DECLARE
   CURSOR customer_cursor IS
      SELECT name, address
      FROM customers
      WHERE salary > 2000 AND city = 'Mumbai';
BEGIN
   FOR cust_rec IN customer_cursor LOOP
      DBMS_OUTPUT.PUT_LINE('Name: ' || cust_rec.name || ', Address: ' || cust_rec.address);
   END LOOP;
END;
/
4.
DECLARE
   CURSOR max_salary_cursor IS
      SELECT *
      FROM customers
      WHERE salary = (SELECT MAX(salary) FROM customers);
BEGIN
   FOR cust_rec IN max_salary_cursor LOOP
      DBMS_OUTPUT.PUT_LINE('Customer ID: ' || cust_rec.customer_id || ', Name: ' || cust_rec.name || ', Salary: ' || cust_rec.salary);
   END LOOP;
END;
/
