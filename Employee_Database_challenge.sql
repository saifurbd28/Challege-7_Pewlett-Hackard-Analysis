-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    emp_no INT NOT NULL,
	title varchar,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


--Deliverable 1: The Number of Retiring Employees by Title

------ 1 to 7 Steps - Create Retirement_titles
select a.emp_no, 
a.first_name, 
a.last_name, 
b.title, 
b.from_date, 
b.to_date 
into Retirement_titles
from employees a
inner join titles b on b.emp_no = a.emp_no
where a.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by a.emp_no


-----Steps 8 - 15 - Create unique_titles

SELECT DISTINCT ON (emp_no) retirement_titles.emp_no,
first_name,
last_name,
title

INTO  unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01' 
ORDER BY emp_no, from_date DESC;


-----------Step 16-21 - Create Retiring_Titles
select 
count(emp_no),
title
into Retiring_Titles
from unique_titles
group by title
order by count(emp_no) desc


--Deliverable 2: The Employees Eligible for the Mentorship Program

select DISTINCT ON (a.emp_no) b.emp_no, 
a.first_name, 
a.last_name, 
a.birth_date,
b.from_date, 
b.to_date,
c.title
into mentorship_eligibilty
from employees a
inner join dept_emp b on b.emp_no = a.emp_no
inner join titles c on c.emp_no = a.emp_no
where (a.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
and c.to_date = '9999-01-01'  and b.to_date = '9999-01-01' 
order by a.emp_no




