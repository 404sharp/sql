-- group function
-- �Ķ���ͷ� row���� �׷����� ���´�.
-- call�Ǵ� Ƚ���� group�� ������ ����Ѵ�.
-- ���ϵǴ� row�� ������ �ϳ�(single function�� ����)
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- ��¥�� ���ؼ��� min�� max�� �� �� �ִ�.
-- min�� ����, max�� �ֱ�
-- Oracle�� ��¥�� long Ÿ���� ���ڷ� ����
select min(hire_date), max(hire_date)
from employees;

-- ����: �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

-- ������ ���� �� �Լ� count: row�� ������ ����
-- *�� ��� �÷��� ������ �� �ִ�.
select count(*)
from employees;

-- ����: 70�� �μ����� �� ������ ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

-- *�� ���� �ȴٸ� PK (primary key)�� �����ϸ� �����ϴ�. null�� ���� �����̴�.
select count(employee_id)
from employees;

-- �׷� �Լ��� null�� �����Ѵ�.
select count(manager_id)
from employees;

-- ���� ������� ��� Ŀ�̼���
select avg(commission_pct)
from employees;

-- ����: ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;

-- �ߺ��Ǵ� �͵� �޴´�. all�� �����Ǿ� �ִ�.
select avg(all salary)
from employees;

-- �ߺ��Ǵ� ���� �����Ѵ�.
select avg(distinct salary)
from employees;

-- ����: ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����: �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;

-- select���� �÷� ������ �����ϸ� group by�� ��� �Ѵ�. �׷��� �����̱� �����̴�.
-- count���� �׷��� ����(12)��ŭ call�ȴ�.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- �׷��� ������ department_id, job_id
-- employee_id�� PK�̹Ƿ� �׷� ���� ��� row�� ī���õȴ�.
select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- ����: ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;

-- �Ϻ� row�� ��󳻵��� �Ϻ� group�� ��󳻰� �ʹ�.
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

-- having������ alias�� �� �� ����.
select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;

select department_id, max(salary)
from employees
-- row�� ��󳽴�. having department_id > 50�� ���� ȿ��
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
-- where������ single function�� ����, group function �Ұ�
where max(salary) > 10000
group by department_id;

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
-- having������ group function ����; �������� group function�� ���Խ�Ű�� �ʹٸ� having�� ���
having sum(salary) > 13000
order by payroll;

-- ����: �Ŵ���ID, �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--       �ּҿ����� $6,000 �ʰ����� �Ѵ�.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
-- 2��° �÷����� ����
order by 2 desc;
--reviewed until here

-- �׷��� N�� �־�� �Ѵ�. �׷��� max(avg(salary))�� �ǹ� �ִ�.
select max(avg(salary))
from employees
-- �׷��Ƿ� group by�� ����Ѵ�.
group by department_id;

-- group function�� 2�������� ��ø�ȴ�.
select sum(max(avg(salary)))
from employees
group by department_id;

-- round �Լ��� 12�� ����ȴ�. ���ϰ��� 12����.
select department_id, round(avg(salary))
from employees
group by department_id;

-- ����: 2001��, 2002��, 2003�⵵�� �Ի��� ���� ��ȸ�϶�.
-- ���1
select to_char(hire_date, 'yyyy') hire_year, count(employee_id) emp_cnt
from employees
where to_char(hire_date, 'yyyy') in (2001, 2002, 2003)
group by to_char(hire_date, 'yyyy')
order by hire_year;
-- ���2
-- ������ �Ի��� ����鿡�� 1�� �ο��ؼ� �ջ��Ѵ�.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;
-- ���3
select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;
-- ���4

-- ����: ������, �μ��� �������� ��ȸ�϶�.
--       �μ��� 20, 50, 80�̴�.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;