-- Link to schema: https://app.quickdatabasediagrams.com/#/d/LsFo3S
-- Physical
CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR(5)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    sex VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id VARCHAR(5)   NOT NULL,
    title VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL
);

CREATE TABLE departments (
    dept_no VARCHAR(5)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_managers (
    dept_no VARCHAR(5)   NOT NULL,
    emp_no INT   NOT NULL
);

CREATE TABLE dept_employees (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(5)   NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_managers ADD CONSTRAINT fk_dept_managers_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_managers ADD CONSTRAINT fk_dept_managers_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_employees ADD CONSTRAINT fk_dept_employees_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_employees ADD CONSTRAINT fk_dept_employees_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE employees
    ALTER COLUMN hire_date TYPE DATE USING hire_date::DATE;

ALTER TABLE employees
    ALTER COLUMN birth_date TYPE DATE USING birth_date::DATE;

-- CHECK IMPORTED DATA FROM CSV'S
SELECT * FROM departments;
SELECT * FROM dept_employees;
SELECT * FROM dept_managers;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;
