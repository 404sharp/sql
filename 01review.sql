select *
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

-- language가 아니라 sqlplus의 command이기 때문에 줄여 쓸 수 있다. semicolon이 없다.
desc departments

-- 나만의 데이터를 만들어 낼 수 있다.
select last_name, salary, salary + 300
from employees;

-- 과제: 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;

-- expression에 null이 포함되면 결과값은 null이다. 여기서는 commission_pct가 nullable
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

-- column name에 별명을 짓는 방법
select last_name as name, commission_pct comm
from employees;

select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- 과제: 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- 과제: 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

-- 붙이기 연산자 column name, alias, expression, constant
select last_name || job_id
from employees;

-- 상수 character를 붙여 보자. 작은따옴표로 묶인 것은 character 타입이다.
select last_name || ' is ' || job_id
from employees;

select last_name || ' is ' || job_id employee
from employees;

select last_name || null
from employees;

-- character와 number가 피연산자로 같이 있다면 character로 변환된다.
select last_name || commission_pct
from employees;

select last_name || salary
from employees;

-- date가 character로 변환된다.
select last_name || hire_date
from employees;

-- character가 있으면 다른 것들은 character로 변환된다.
select last_name || (salary * 12)
from employees;

-- 과제: 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;