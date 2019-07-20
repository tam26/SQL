DROP TABLE IF EXISTS Department_Managers;
DROP TABLE IF EXISTS Department_Employees;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Salaries;

DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Departments (
	dept_no varchar(50) PRIMARY NOT null,
	dept_name varchar(50) NOT null
);

select * from employees;

CREATE TABLE Department_Managers (
	dept_no varchar(50) NOT null,
	emp_no int NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE Department_Employees (
	emp_no int NOT null,
	dept_no varchar NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN (emp_no) REFERENCES employees(emp_no),
	FOREIGN (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE Employees (
	emp_no int PRIMARY KEY NOT null,
	birth_date date NOT null,
	first_name varchar(50) NOT null,
	last_name varchar(50) NOT null,
	gender varchar(50) NOT null,
	hire_date date NOT null
);

CREATE TABLE Titles (
	emp_no int NOT null,
	title varchar(50) NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE Salaries (
	emp_no int NOT null,
	salary int NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN (emp_no) REFERENCES employees(emp_no)
);

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.gender, Salaries.salary
FROM Employees
JOIN Salaries
	ON Employees.emp_no = Salaries.emp_no

--List employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT Departments.dept_no, Departments.dept_name, Department_Managers.emp_no, Department_Managers.from_date, Department_Managers.to_date, Employees.first_name, Employees.last_name
FROM Departments
JOIN Department_Managers
	ON Departments.dept_no = Department_Managers.dept_no 
JOIN Employees 
	ON Department_Managers.emp_no = Employees.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT Employees.emp_no, Employees.first_name, Employees.last_name, Departments.dept_name
FROM Departments 
JOIN Department_Employees 
	ON Departments.dept_no = Department_Employees.dept_no
JOIN Employees 
	ON Employees.emp_no = Department_Employees.emp_no

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT Department_Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Department_Employees
JOIN Employees
	ON Department_Employees.emp_no = Employees.emp_no
JOIN Departments
	ON Department_Employees.dept_no = Departments.dept_no
WHERE Departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT Department_Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name 
FROM Department_Employees
JOIN Employees
	ON Department_Employees.emp_no = employees.emp_no
JOIN Departments
	ON Department_Employees.dept_no = departments.dept_no
WHERE Departments.dept_name = 'Sales' OR Departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT (last_name) AS "frequency"
FROM Employees
GROUP BY last_name
ORDER BY COUNT (last_name) DESC;
