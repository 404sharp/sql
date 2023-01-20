-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
-- ���� �÷��� ���� ã�´�. �׸��� ����(=)(�׷��� equi join) �����Ͱ� �ִ� row���� �����Ѵ�.
-- ���⼭�� location_id�� ���� row���� �����Ѵ�. �������� ������.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- ���� �÷��� ���� �ڵ�� �巯����.
select employee_id, last_name, department_id, location_id
from employees join departments
-- ���� �÷��� using�� ��ȣ �ȿ� ����Ѵ�. department_id�� ������ join�ȴ�.
using (department_id);

-- ����: ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
-- departments ���̺� department_id�� null�� �ִ��� = ���꿡�� true�� ������ �����Ƿ� join���� �ʴ´�.
where department_id is null;

-- natural join�� ���̺���� ��� ���� �÷��� ����Ѵ�. �׷��� ����� 32���̴�.
-- ���� department_id�� manager_id�� ���ƾ� join�ȴ�. (table model�� ���� �� ���� �����̴�.)
select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
-- �� ���̺��� location_id�� 1400�� row�� ��� join�Ѵ�.
where location_id = 1400;

-- ���̺�� ���ڸ� �� �� �ִ�.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
-- ����: using�� ���� �÷����� ���λ縦 ������ �ʴ´�.
where d.location_id = 1400;

-- ����: using�� ���� �÷����� ���λ縦 ������ �ʴ´�.
select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
-- using�� ������ ���� ���� �÷����� ���λ縦 �ٿ��� �Ѵ�.
where d.manager_id = 100;

-- = �����ڸ� �巯����.
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id;

-- 3�� �̻��� table�� join�Ѵ�.
select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����: �� query�� using���� refactoring�϶�.
select employee_id, city, department_name
from employees e join departments d
-- using�� ���� = �����ڸ� ������� �ʴ´�.
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
-- 149�� ����� ������� ��󳽴�.
where e.manager_id = 149;

-- ����: Toronto�� ��ġ�� �μ����� ���ϴ� �������
--       �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id, 
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join
-- programmer��ŭ �� �޴� ������� ã�´�.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- self join
-- �ϳ��� ���̺� �ִ� row�鳢�� join�Ѵ�.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager_last_name mgr
from employees worker join employees manager
-- ����: ���� ���̺��̶� ���λ縦 �����ϸ� ��Ȯ���� �Ҵ´�.
on manager_id = employee_id;

-- ����: ���� ���̺��̶� ���λ縦 �����ϸ� ��Ȯ���� �Ҵ´�.
select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- ����: ���� �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������� ��ȸ�϶�.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id
order by 1, 2, 3;

-- ����: Davies���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date
from employees e join employees x
on x.last_name = 'Davies'
and e.hire_date > x.hire_date;

-- ����: �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ�����, �Ŵ��� �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join
select e.last_name, e.department_id, d.department_name
-- Grant�� ��Ÿ����.
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
-- ����� ���� �μ��� ��Ÿ����.
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
-- left�� right�� ȿ���� ��� ��Ÿ����.
from employees e full outer join departments d
on e.department_id = d.department_id;

-- ����: ������� �̸�, ���, �Ŵ�����, �Ŵ����� ����� ��ȸ�϶�.
--       King ȸ�嵵 ���̺� �����϶�.
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;

-- ���� ����
-- inner join + equi join
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

-- ���� ����
-- 3�� ���̺� join
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

-- ���� ����
-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- ���� ���� ���� (+)�� ���δ�. ���� ���ʿ� �����Ƿ� right outer join
where e.department_id(+) = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- ���� �����ʿ� �����Ƿ� left outer join
where e.department_id = d.department_id(+);

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- full outer join�� ����.
where e.department_id(+) = d.department_id(+);

select worker.last_name || ' works for ' || manager.last_name
-- self join
from employees worker, employees manager
where worker.manager_id = manager.employee_id;