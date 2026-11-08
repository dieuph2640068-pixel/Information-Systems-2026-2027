-- Who have the same name as the managers of the "Finance" department?
#Check manager name
SELECT employees.emp_no, first_name, last_name, dept_manager.from_date, dept_manager.to_date
    FROM employees
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
    JOIN departments ON dept_emp.dept_no = departments.dept_no
    WHERE departments.dept_name = "Finance";
# Find employee that have same name
SELECT * 
    FROM employees
    WHERE CONCAT(first_name, ' ', last_name) IN (
        SELECT CONCAT(first_name, ' ', last_name)
            FROM employees
            JOIN dept_manager USING (emp_no)
            WHERE dept_no = (
                SELECT dept_no
                FROM departments
                WHERE dept_name = 'Finance'
            )
    );

-- Who in the "Production" department were hired after the promotion of the last manager in that department?
SELECT *
    FROM employees
    JOIN dept_emp USING (emp_no)
    WHERE dept_no = (
        SELECT dept_no
        FROM departments
        WHERE dept_name = 'Production')
    AND hire_date > (
        SELECT MAX(from_date)
        FROM dept_manager
        WHERE dept_no = (
            SELECT dept_no
            FROM departments
            WHERE dept_name = 'Production'));

-- Find the average salary of each department, from highest to lowest.
SELECT dept_name, (
    SELECT AVG(salary)
        FROM salaries
        JOIN dept_emp USING (emp_no)
        WHERE dept_no = departments.dept_no) AS average_salary
    FROM departments
    ORDER BY average_salary DESC;

-- Find the average salary for each type of Engineer, from highest to lowest
SELECT title, average_salary
    FROM (
        SELECT title, AVG(salary) AS average_salary
        FROM titles
        JOIN salaries USING (emp_no)
        WHERE title LIKE '%Engineer%'
        GROUP BY title) AS engineer_salaries
    ORDER BY average_salary DESC;    