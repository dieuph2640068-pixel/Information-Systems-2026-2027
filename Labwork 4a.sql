USE employees;

-- What is the average salary of each employee?
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name, AVG(salary) AS average_salary
    FROM employees
    JOIN salaries USING (emp_no)
    GROUP BY emp_no;

-- How much was each employee paid in total?
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name, SUM(salary) AS total_salary
    FROM employees
    JOIN salaries USING (emp_no)
    GROUP BY emp_no;

-- Minimum, maximum and total salaries of each department?
SELECT dept_name, MIN(salary) AS min_salary, MAX(salary) AS max_salary, SUM(salary) AS total_salary
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN salaries USING (emp_no)
    GROUP BY dept_no, dept_name;

-- Which departments have paid more than 20 billion dollars for their employees?
SELECT dept_name, SUM(salary) AS total_salary
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN salaries USING (emp_no)
    GROUP BY dept_no, dept_name
    HAVING SUM(salary) > 20000000000;

-- Total salaries of male employees in each department?
SELECT dept_name, SUM(salary) AS total_salary
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN employees USING (emp_no)
    JOIN salaries USING (emp_no)
    WHERE gender = 'M'
    GROUP BY dept_no, dept_name;

-- Total salaries of department managers for each department, from highest to lowest?
SELECT dept_name, SUM(salary) AS total_salary
    FROM departments
    JOIN dept_manager USING (dept_no)
    JOIN salaries USING (emp_no)
    GROUP BY dept_no, dept_name
    ORDER BY total_salary DESC;