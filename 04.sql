select hire_date
from employees
-- character가 date로 자동 변환된다. hire_date는 갯수가 많으므로 변환시 비경제적.
where hire_date = '2003/06/17';

select salary
from employees
-- character가 number로 자동 변환된다.
where salary = '7000';

-- date가 character로 변환된다.
select hire_date || ''
from employees;

-- number가 character로 변환된다.
select salary || ''
from employees;

-- 가장 만만한 게 character로 변환되는 것이다.
select to_char(hire_date)
from employees;

-- 날짜 형식을 기술할 수 있다.
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- DDsp는 날짜를 spelled number, 즉 문자로 표현한다.
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

-- 오늘 요일을 문자 코드로 리턴한다. (1=sunday, 2=monday, ...)
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- 과제: 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day') day,
    to_char(hire_date, 'd')
from employees
-- 월요일의 숫자값을 1로 바꾼다.
order by to_char(hire_date - 1, 'd'), hire_date;

-- 시간표시
select to_char(sysdate, 'hh24:mi:ss am')
from dual;

-- 일반문자는 큰따옴표 안에 넣는다.
select to_char(sysdate, 'DD "of" Month')
from dual;

-- fm: fill mode -- leading 0, trailing blank characters를 뺀다.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- 과제: 사원들의 이름, 입사일, 인사평가일을 조회하라.
--       인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--       날짜는 YYYY.MM.DD로 표시한다.
select last_name,
    to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
-- reviewed until here

-- 이제부터 숫자를 문자로 바꿔보자.
select to_char(salary)
from employees;

-- 0으로 표기하면 값이 없는 앞자리를 0으로 채운다. leading 0
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

-- 과제: <이름> earns <$,월급> monthly but wants <$,월급 x 3>. 로 조회하라.
select last_name || ' earns ' ||
    to_char(salary, 'fm$99,999') || ' monthly but wants ' ||
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- 문자를 날짜로 바꿔본다.
select last_name, hire_date
from employees
-- 포맷을 지정해 준다.
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
-- 포맷을 개떡같이 말해도 찰떡같이 알아먹는다.
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
-- fx를 넣으면 포맷이 정확해야 한다. (format exact)
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy');

-- 숫자는 우측정렬된다.
select to_number('1237')
from dual;

-- 에러
select to_number('1,237.12')
from dual;

-- 해석할 수 있도록 포맷을 넣어준다.
select to_number('1,237.12', '9,999.99')
from dual;

-- 두 번째로 많이 쓰이는 single function
-- 내 테이블에서 null을 없앤다. 첫번째 파라미터가 null이면 두번째 파라미터로 바꾼다.
-- 두 파라미터의 타입은 동일해야 한다. 같은 컬럼이므로 동일한 데이터 타입이어야 한다.
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제: 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제: 사원들의 이름, 커미션율을 조회하라.
--       커미션이 없으면, No Commission을 표시한다.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

-- nvl2는 첫번째 파라미터가 not null이면 2번째, null이면 3번째 파라미터로 대치한다.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

-- 0은 문자이다.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- nullif: 두 파라미터 값이 같으면 null, 다르면 첫번째 값을 리턴한다.
select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees;

-- null은 타입 안 가린다. 하지만 타입을 정해줄 수도 있다.
select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce는 파라미터들의 데이터 타입이 동일해야 한다.
-- 처음으로 null이 아닌 값이 리턴된다. (첫번째 - 두번째 - 세번째 파라미터 순으로)
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

select last_name, salary,
    -- 소득세율
    -- switch..case 비슷
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

-- decode의 기본값(default)은 null이다.
-- 기준값과 비교값의 타입은 같아야 한다. 여기서는 salary가 문자형으로 변환된다.
select decode(salary, 'a', 1)
from employees;

-- 기본값을 0으로 지정했다.
select decode(salary, 'a', 1, 0)
from employees;

-- job_id가 숫자로 변환될 수 없으므로 에러가 난다.
select decode(job_id, 1, 1)
from employees;

-- 과제: 사원들의 직업, 직업별 등급을 조회하라.
--       기본 등급은 null이다.
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

-- decode의 효과를 갖는 문법을 배워보자. case..when..then..else..end
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

-- 리턴값들의 타입은 동일해야 한다. 기본값 포함
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

-- 기준값과 비교값의 타입은 같아야 한다. salary가 숫자이므로 when 뒤도 숫자여야 한다.
select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select last_name, salary,
    -- case when 뒤에는 조건문이 들어간다.
    -- when들은 배타적이다.
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- 과제: 사원들의 이름, 입사일, 입사요일을 월요일부터 요일순으로 조회하라.
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

-- 과제: 2005년 이전에 입사한 사원들에게 100만원 상품권,
--       2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--       사원들의 이름, 입사일, 상품권 금액을 조회하라.
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원'
    end gift
from employees
order by gift, hire_date;