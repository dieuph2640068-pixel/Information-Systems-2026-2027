USE employees;

#All info of all employees
SELECT * FROM employees;
#All info of all departments
SELECT * FROM departments;
#Full names of all employees
SELECT CONCAT(first_name, ' ', last_name) as full_name FROM employees;
#Names of all departments
SELECT departments.dept_name FROM departments;

#Full names of employees working in “Sales” department
SELECT CONCAT(first_name, ' ', last_name) as full_name, dept_name
    FROM employees
    CROSS JOIN departments WHERE dept_name = 'Sales';

#Full names of male employees working in “Finance” department
SELECT CONCAT(first_name, ' ', last_name) AS full_name, gender, dept_name
    FROM employees
    CROSS JOIN departments
    WHERE dept_name = 'Finance' AND gender = 'M';

#Salaries of female employees working in “Marketing” department
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name, salary, dept_name
    FROM employees
    JOIN dept_emp USING (emp_no)
    JOIN departments USING (dept_no)
    JOIN salaries USING (emp_no)
    WHERE gender = 'F' AND dept_name = 'Marketing';

#Full names of employees who have the same last name as their manager
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS full_name
    FROM employees
    JOIN dept_emp USING (emp_no)
    JOIN dept_manager USING (dept_no)
    JOIN employees AS managers ON dept_manager.emp_no = managers.emp_no
    WHERE employees.last_name = managers.last_name;

#Full names of managers who have been doing the job at least twice
SELECT CONCAT(first_name, ' ', last_name) AS full_name, dept_name
    FROM employees
    JOIN dept_manager USING (emp_no)
    JOIN departments USING (dept_no)
    GROUP BY emp_no, first_name, last_name, dept_name
    HAVING COUNT(*) >= 2;

#Full names of employees who was paid more than $100000
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS full_name, salaries.salary
    FROM employees
    JOIN salaries USING (emp_no)
    WHERE salary > 100000;

#Names of all departments that have employees paid more than $100000
SELECT DISTINCT dept_name
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN salaries USING (emp_no)
    WHERE salary > 100000;

#Due to changes in company’s organization, the following departments are merged
-- Development (d005) and Research (d008) to Research and Development(d010)
UPDATE dept_emp
    SET dept_no = 'd010'
    WHERE dept_no IN ('d005', 'd008') AND to_date = '9999-01-01';

UPDATE departments
    SET dept_name = 'Research and Development'
    WHERE dept_no = 'd010';

DELETE FROM departments
    WHERE dept_no IN ('d005', 'd008');

-- Marketing (d001) and Sales (d007) to Marketing and Sales (d011) 
UPDATE dept_emp
    SET dept_no = 'd011'
    WHERE dept_no IN ('d001', 'd007') AND to_date = '9999-01-01';

UPDATE departments
    SET dept_name = 'Marketing and Sales'
    WHERE dept_no = 'd011';

DELETE FROM departments
    WHERE dept_no IN ('d001', 'd007');