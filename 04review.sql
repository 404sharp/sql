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
    to_char(hire_date, 'YYYY.MM.DD'), 
    to_char(next_day(add_months(hire_date, 3), 'mon'), 'YYYY.MM.DD')
from employees;