--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp_no,
(SELECT salary
	FROM salaries
	WHERE employees.emp_no = salaries.emp_no
 )  AS "employee_number", last_name,first_name,sex
FROM employees;

--2.List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date)=1986;

--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no AS "department_no", dept_manager.emp_no AS "employee_number",employees.first_name,employees.last_name,
 (SELECT dept_name AS "department_name"
  FROM departments
  WHERE departments.dept_no = dept_manager.dept_no)
 FROM dept_manager
 LEFT JOIN employees
 ON employees.emp_no = dept_manager.emp_no;

--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no AS "employee_number",employees.first_name,employees.last_name,
 (SELECT dept_name AS "department_name"
  FROM departments
  WHERE departments.dept_no = dept_emp.dept_no)
 FROM dept_emp
 LEFT JOIN employees
 ON employees.emp_no = dept_emp.emp_no;

--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW department AS
SELECT dept_emp.emp_no AS "employee_number",employees.first_name,employees.last_name,
 (SELECT dept_name AS "department_name"
  FROM departments
  WHERE departments.dept_no = dept_emp.dept_no)
 FROM dept_emp
 LEFT JOIN employees
 ON employees.emp_no = dept_emp.emp_no;

SELECT *
FROM department
WHERE department_name = 'Sales';

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT *
FROM department
WHERE department_name = 'Sales'
OR department_name = 'Development';

--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(emp_no), last_name  
FROM employees
GROUP BY last_name
ORDER BY COUNT(emp_no) DESC;