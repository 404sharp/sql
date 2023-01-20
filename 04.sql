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
    to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
-- reviewed until here

-- �������� ���ڸ� ���ڷ� �ٲ㺸��.
select to_char(salary)
from employees;

-- 0���� ǥ���ϸ� ���� ���� ���ڸ��� 0���� ä���. leading 0
select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

-- leading 0
select '|' || to_char(12.12, '9999.99') || '|',
    '|' || to_char(12.12, '0000.00') || '|'
from dual;

-- fill mode
select '|' || to_char(12.12, 'fm9999.99') || '|',
    '|' || to_char(12.12, 'fm0000.00') || '|'
from dual;

-- local currency
select to_char(1237, 'L9999')
from dual;

-- ����: <�̸�> earns <$,����> monthly but wants <$,���� x 3>. �� ��ȸ�϶�.
select last_name || ' earns ' ||
    to_char(salary, 'fm$99,999') || ' monthly but wants ' ||
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- ���ڸ� ��¥�� �ٲ㺻��.
select last_name, hire_date
from employees
-- ������ ������ �ش�.
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
-- ������ �������� ���ص� �������� �˾ƸԴ´�.
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
-- fx�� ������ ������ ��Ȯ�ؾ� �Ѵ�. (format exact)
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy');

-- ���ڴ� �������ĵȴ�.
select to_number('1237')
from dual;

-- ����
select to_number('1,237.12')
from dual;

-- �ؼ��� �� �ֵ��� ������ �־��ش�.
select to_number('1,237.12', '9,999.99')
from dual;

-- �� ��°�� ���� ���̴� single function
-- �� ���̺��� null�� ���ش�. ù��° �Ķ���Ͱ� null�̸� �ι�° �Ķ���ͷ� �ٲ۴�.
-- �� �Ķ������ Ÿ���� �����ؾ� �Ѵ�. ���� �÷��̹Ƿ� ������ ������ Ÿ���̾�� �Ѵ�.
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- ����: ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- ����: ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--       Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

-- nvl2�� ù��° �Ķ���Ͱ� not null�̸� 2��°, null�̸� 3��° �Ķ���ͷ� ��ġ�Ѵ�.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

-- 0�� �����̴�.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- nullif: �� �Ķ���� ���� ������ null, �ٸ��� ù��° ���� �����Ѵ�.
select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees;

-- null�� Ÿ�� �� ������. ������ Ÿ���� ������ ���� �ִ�.
select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce�� �Ķ���͵��� ������ Ÿ���� �����ؾ� �Ѵ�.
-- ó������ null�� �ƴ� ���� ���ϵȴ�. (ù��° - �ι�° - ����° �Ķ���� ������)
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

select last_name, salary,
    -- �ҵ漼��
    -- switch..case ���
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
        -- default
            0.45) tax_rate
from employees
where department_id = 80;

-- decode�� �⺻��(default)�� null�̴�.
-- ���ذ��� �񱳰��� Ÿ���� ���ƾ� �Ѵ�. ���⼭�� salary�� ���������� ��ȯ�ȴ�.
select decode(salary, 'a', 1)
from employees;

-- �⺻���� 0���� �����ߴ�.
select decode(salary, 'a', 1, 0)
from employees;

-- job_id�� ���ڷ� ��ȯ�� �� �����Ƿ� ������ ����.
select decode(job_id, 1, 1)
from employees;

-- ����: ������� ����, ������ ����� ��ȸ�϶�.
--       �⺻ ����� null�̴�.
--       IT_PROG   A
--       AD_PRES   B
--       ST_MAN    C
--       ST_CLERK  D
select job_id, decode(job_id,
    'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN', 'C',
    'ST_CLERK', 'D') grade
from employees;

-- decode�� ȿ���� ���� ������ �������. case..when..then..else..end
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

-- ���ϰ����� Ÿ���� �����ؾ� �Ѵ�. �⺻�� ����
select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case job_id when '1' then '1'
                    when '2' then '2'
                    else '0'
        end grade
from employees;

-- ���ذ��� �񱳰��� Ÿ���� ���ƾ� �Ѵ�. salary�� �����̹Ƿ� when �ڵ� ���ڿ��� �Ѵ�.
select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select last_name, salary,
    -- case when �ڿ��� ���ǹ��� ����.
    -- when���� ��Ÿ���̴�.
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- ����: ������� �̸�, �Ի���, �Ի������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
            when 'monday' then 1
            when 'tuesday' then 2
            when 'wednesday' then 3
            when 'thursday' then 4
            when 'friday' then 5
            when 'saturday' then 6
            when 'sunday' then 7
        end;

-- ����: 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--       2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--       ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100����'
        else '10����'
    end gift
from employees
order by gift, hire_date;