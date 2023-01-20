-- set
-- set���� �ߺ��� ���� ������� �ʴ´�. set���� Ű�� ���� �����̴�.
-- list�� Ű�� �����Ƿ� value�� �ߺ��Ǿ ������ �����ϴ�.
-- ���̺��� set�̴�. �ߺ��Ǵ� ���� �����ϱ� ���� PK�� �ִ� ���̴�.

-- ������
-- �÷��� ������ ������ Ÿ���� ���ƾ� �Ѵ�.
select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
-- �ߺ��� �������� �ʴ´�. 176, 200���� 2���� �ִ�.
union all
select employee_id, job_id
from job_history
order by employee_id;

-- ����: ���� ������ ���� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
-- ���1
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id
                    and e.job_id = j.job_id);
-- ���2
select employee_id, last_name, job_id
from employees e
where e.job_id in (select job_id
                    from job_history j
                    where e.employee_id = j.employee_id);
-- ���3
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;