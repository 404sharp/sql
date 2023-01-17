-- single function
desc dual

select * from dual;

-- �Ķ���ͷ� row �ϳ��� ����. �׷��� single function�̴�.
select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
-- ����� ����.
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
-- lower function�� ���ϰ��� ����� ���Ѵ�.
where lower(last_name) = 'higgins';

select concat('Hello', 'World')
from dual;

-- �ϳ��� row, �� ���� field�� �Ķ���ͷ� �޴´�.
-- 2��° ���ں��� �����ؼ� 5���� ���ڸ� �̾Ƴ���.
select substr('HelloWorld', 2, 5)
from dual;

-- �������� ������ �����̴�.
select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

-- �ش��ϴ� ���ڰ� ��� ��ġ�� �ִ°�
-- ���ʿ��� 3��°
-- ���ϰ��� 0���� ũ�� �ش� ���ڰ� �ִ�.
select instr('Hello', 'l')
from dual;
-- ���ϰ��� 0�̸� �ش� ���ڰ� ����.
select instr('Hello', 'w')
from dual;

-- padding: 5�ڸ�, ���� �ڸ��� *�� ä���.
select lpad(salary, 5, '*')
from employees;

select rpad(salary, 5, '*')
from employees;

-- J��� ���ڸ� BL�� ��ġ�Ѵ�.
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- �ش� ���ڸ� �Ӹ��� �������� ����.
select trim('H' from 'Hello')
from dual;

-- �Ӹ��� ������ ������ �� ����.
select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

-- ����: �� query���� ' '�� trim������, ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

-- �⺻���� �����̽���. ���� �����ϴ�.
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
-- substr: ���ڼ��� �����ϸ� ��ü ����
where substr(job_id, 4) = 'PROG';

-- ����: �� query����, where���� like�� refactoring�϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';
