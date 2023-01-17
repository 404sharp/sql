select *
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

-- language�� �ƴ϶� sqlplus�� command�̱� ������ �ٿ� �� �� �ִ�. semicolon�� ����.
desc departments

-- ������ �����͸� ����� �� �� �ִ�.
select last_name, salary, salary + 300
from employees;

-- ����: ������� ����, ������ ��ȸ�϶�.
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;

-- expression�� null�� ���ԵǸ� ������� null�̴�. ���⼭�� commission_pct�� nullable
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

-- column name�� ������ ���� ���
select last_name as name, commission_pct comm
from employees;

select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- ����: ������� ���, �̸�, ����, �Ի���(STARTDATE)�� ��ȸ�϶�.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- ����: ������� ���(Emp #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

-- ���̱� ������ column name, alias, expression, constant
select last_name || job_id
from employees;

-- ��� character�� �ٿ� ����. ��������ǥ�� ���� ���� character Ÿ���̴�.
select last_name || ' is ' || job_id
from employees;

select last_name || ' is ' || job_id employee
from employees;

select last_name || null
from employees;

-- character�� number�� �ǿ����ڷ� ���� �ִٸ� character�� ��ȯ�ȴ�.
select last_name || commission_pct
from employees;

select last_name || salary
from employees;

-- date�� character�� ��ȯ�ȴ�.
select last_name || hire_date
from employees;

-- character�� ������ �ٸ� �͵��� character�� ��ȯ�ȴ�.
select last_name || (salary * 12)
from employees;

-- ����: ������� '�̸�, ����'(Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' || job_id "Emp and Title"
from employees;