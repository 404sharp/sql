-- subquery
-- main query���� response�� ����� ����.
select last_name, salary
from employees
-- outer query(��ȣ ����)�� main query�̴�.
where salary > (select salary
                from employees
                where last_name = 'Abel');

-- Ernst�� ���� ������ ���� �ְ� �� ���� ���� ����� ã�´�.
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');

-- ����: Kochhar���� �����ϴ� ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');
-- reviewed until here

-- ����: IT�μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ��ȸ�϶�.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'IT');

-- ����: Abel�� ���� �μ����� ���ϴ� ������� �̸�, �Ի����� ��ȸ�϶�.
--       �̸� ������ �������� �����Ѵ�.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees
-- ����: subquery�� ���ϵǴ� ���� 2�� �̻��̴�. > �����ڴ� �¿��� ��� �ϳ����� �־�� �Ѵ�.
where salary > (select salary
                from employees
                where last_name = 'King');

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- ����: ȸ�� ��� ���� �̻� ���� ������� ���, �̸�, ������ ��ȸ�϶�.
--       ���� �������� �����Ѵ�.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;

-- ����: = �����ڴ� �¿��� �ϳ����� �־�� �Ѵ�.
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id);

-- ���ĺ���.
select employee_id, last_name
from employees
where salary in (select min(salary)
                from employees
                group by department_id);

-- ����: �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���, �̸��� ��ȸ�϶�.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- ����: 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);

-- subquery ���ϰ��� ���� ���� �� ���� ������
-- =any�� in�� ���� ����.
select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from departments
                    where location_id = 1700);

select employee_id, last_name, job_id, salary
from employees
-- <any�� 9000 �̸�
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
-- <all�� 4200�̸�
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- ����: 60�� �μ��� �Ϻ� ������� �޿��� ���� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);

-- ����: ȸ�� ��� ���޺���, �׸��� ��� ���α׷��Ӻ��� ������ �� �޴�
--       ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG');

-- subquery�� ���ϰ��� ���� �� (row�� ���� ��)
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);

select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');

-- subquery���� null�� ������ ��: ������ �� �ȴ�. ��������.
-- in�� =any
select last_name
from employees
where employee_id in (select manager_id
                        from employees);

-- ����� ����.
-- not in�� <>all
select last_name
from employees
where employee_id not in (select manager_id
                        from employees);

-- ����: �� ������ all �����ڷ� refactoring�϶�.
select last_name
from employees
where employee_id <>all (select manager_id
                        from employees);

select count(*)
from departments;

-- exists: �����ϸ� true�� �������� ������ false��.
-- from ��ǰ ���̺� exists..from �ֹ� ���̺��� �Ͽ� �ֹ��� ���� �ִ� �͸� ��� �� �ִ�.
select count(*)
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);

-- ����: ������ �ٲ� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id);