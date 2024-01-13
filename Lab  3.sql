Task 1:
DECLARE
  v_id VARCHAR2(20) := '2022-1-60-018';
  v_name VARCHAR2(50) := 'Tanjela';
  v_department VARCHAR2(50) := 'CSE';
  v_university VARCHAR2(100) := 'East West University';
  v_address VARCHAR2(150) := 'B block, South Banasree, Dhaka-1219';
  v_email VARCHAR2(50) := 'tanjela01@gmail.com';

BEGIN
  DBMS_OUTPUT.PUT_LINE('Id: ' || v_id);
  DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
  DBMS_OUTPUT.PUT_LINE('Department: ' || v_department);
  DBMS_OUTPUT.PUT_LINE('University: ' || v_university);
  DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
  DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
END;
/
Task2:
DECLARE
  v_salary1 NUMBER;
  v_salary2 NUMBER;
  v_total_salary NUMBER;

BEGIN
  
  SELECT salary INTO v_salary1 FROM salary_table WHERE id = 1;
  SELECT salary INTO v_salary2 FROM salary_table WHERE id = 2;

  v_total_salary := v_salary1 + v_salary2;

  DBMS_OUTPUT.PUT_LINE('Total Salary for ID 1 and 2: ' || v_total_salary);
END;
/


Task3:
DECLARE
  v_name VARCHAR2(50);
  v_address VARCHAR2(150);
  v_salary NUMBER;

BEGIN

  SELECT name, address, salary INTO v_name, v_address, v_salary FROM details_table WHERE id = 4;

  DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
  DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
  DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
END;
/
