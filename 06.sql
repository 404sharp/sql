-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equijoin
-- ���� �÷��� ���� ã�´�. �׸��� ����(=)(�׷��� equijoin) �����Ͱ� �ִ� row���� �����Ѵ�.
-- ���⼭�� location_id�� ���� row���� �����Ѵ�. �������� ������.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- ���� �÷��� ���� �ڵ�� �巯����.
select employee_id, last_name, department_id, location_id
from employees join departments
-- ���� �÷��� using�� ����Ѵ�. department_id�� ������ join�ȴ�.
using (department_id);

-- ����: ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
-- departments ���̺� department_id�� null�� �ִ��� = ���꿡�� true�� ������ �����Ƿ� join���� �ʴ´�.
where department_id is null;

-- natural join�� ���̺���� ��� ���� �÷��� ����Ѵ�. �׷��� ����� 32���̴�.
-- ���� department_id�� manager_id�� ���ƾ� join�ȴ�.
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
-- ����
where d.location_id = 1400;

-- ����: using�� ���� �÷����� ���λ縦 ������ �ʴ´�.
select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;