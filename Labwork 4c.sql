-- Who have the same name as the managers of the “Finance” department?
# 1: Create a view containing the names of Finance managers.
CREATE VIEW finance_managers AS
SELECT
    first_name,
    last_name
FROM employees
JOIN dept_manager USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_name = 'Finance';
# 2: Find employees who have the same full name as those managers.
SELECT *
FROM employees
WHERE (first_name, last_name) IN (
    SELECT first_name, last_name
    FROM finance_managers
);

-- Who in the “Production” department were hired after the promotion of the last manager in that department?
# 1: Create a view to find the latest manager promotion date in Production.
CREATE VIEW production_last_manager AS
    SELECT MAX(from_date) AS last_promotion_date
    FROM dept_manager
    JOIN departments USING (dept_no)
    WHERE dept_name = 'Production';
# 2: Find employees hired after that date.
SELECT *
    FROM employees
    JOIN dept_emp USING (emp_no)
    JOIN departments USING (dept_no)
    WHERE dept_name = 'Production'
    AND hire_date > (
        SELECT last_promotion_date
        FROM production_last_manager);

-- Find the average salary of each department, from highest to lowest.
# 1: Create a view containing the average salary of each department.
CREATE VIEW department_average_salary AS
SELECT dept_no, dept_name, AVG(salary) AS average_salary
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN salaries USING (emp_no)
    GROUP BY dept_no, dept_name;
# 2: Display the results from highest to lowest.
SELECT *
    FROM department_average_salary
    ORDER BY average_salary DESC;

-- Find the average salary for each type of Engineer, from highest to lowest
# 1: Create a view containing the average salary for each Engineer title.
CREATE VIEW engineer_average_salary AS
SELECT title, AVG(salary) AS average_salary
    FROM titles
    JOIN salaries USING (emp_no)
    WHERE title LIKE '%Engineer%'
    GROUP BY title;
# 2: Display the results from highest to lowest.
SELECT *
    FROM engineer_average_salary
    ORDER BY average_salary DESC;