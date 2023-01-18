select hire_date
from employees
-- character�� date�� �ڵ� ��ȯ�ȴ�. hire_date�� ������ �����Ƿ� ��ȯ�� �������.
where hire_date = '2003/06/17';

select salary
from employees
-- character�� number�� �ڵ� ��ȯ�ȴ�.
where salary = '7000';

-- date�� character�� ��ȯ�ȴ�.
select hire_date || ''
from employees;

-- number�� character�� ��ȯ�ȴ�.
select salary || ''
from employees;

-- ���� ������ �� character�� ��ȯ�Ǵ� ���̴�.
select to_char(hire_date)
from employees;

-- ��¥ ������ ����� �� �ִ�.
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- DDsp�� ��¥�� spelled number, �� ���ڷ� ǥ���Ѵ�.
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

-- ���� ������ ���� �ڵ�� �����Ѵ�. (1=sunday, 2=monday, ...)
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- ����: �� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.
select last_name, hire_date,
    to_char(hire_date, 'day') day,
    to_char(hire_date, 'd')
from employees
-- �������� ���ڰ��� 1�� �ٲ۴�.
order by to_char(hire_date - 1, 'd'), hire_date;

-- �ð�ǥ��
select to_char(sysdate, 'hh24:mi:ss am')
from dual;

-- �Ϲݹ��ڴ� ū����ǥ �ȿ� �ִ´�.
select to_char(sysdate, 'DD "of" Month')
from dual;

-- fm: fill mode -- leading 0, trailing blank characters�� ����.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- ����: ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--       �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--       ��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name, 
    to_char(hire_date, 'YYYY.MM.DD'), 
    to_char(next_day(add_months(hire_date, 3), 'mon'), 'YYYY.MM.DD')
from employees;