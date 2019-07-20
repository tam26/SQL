CREATE TABLE Departments (
	dept_no varchar(50) PRIMARY KEY NOT null,
	dept_name varchar(50) NOT null
);

CREATE TABLE Employees (
	emp_no int PRIMARY KEY NOT null,
	birth_date date NOT null,
	first_name varchar(50) NOT null,
	last_name varchar(50) NOT null,
	gender varchar(50) NOT null,
	hire_date date NOT null
);

CREATE TABLE Department_Managers (
	dept_no varchar(50) NOT null,
	emp_no int NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE Department_Employees (
	emp_no int NOT null,
	dept_no varchar NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE Titles (
	emp_no int NOT null,
	title varchar(50) NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE Salaries (
	emp_no int NOT null,
	salary int NOT null,
	from_date date NOT null,
	to_date date NOT null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
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
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM Departments AS d
INNER JOIN Department_Managers AS dm 
	ON (dm.dept_no = d.dept_no)
JOIN Employees AS e 
	ON (e.emp_no = dm.emp_no);

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM Departments AS d
JOIN Department_Employees AS de
	ON (d.dept_no = de.dept_no)
JOIN Employees AS e
	ON (e.emp_no = de.emp_no);

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
