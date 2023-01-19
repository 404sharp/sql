-- single function
desc dual

select * from dual;

-- 파라미터로 row 하나가 들어갔다. 그래서 single function이다.
select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
-- 결과가 없다.
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
-- lower function의 리턴값과 문자 상수를 비교한다.
where lower(last_name) = 'higgins';

select concat('Hello', 'World')
from dual;

-- 하나의 row, 세 개의 field를 파라미터로 받는다.
-- index:2번째 글자부터 시작해서 length:5개의 글자를 뽑아낸다.
select substr('HelloWorld', 2, 5)
from dual;

-- index:음수값은 방향이 왼쪽이다.
select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

-- 해당하는 글자가 어느 위치(index)에 있는가
-- 왼쪽에서 3번째
-- 리턴값이 0보다 크면 해당 글자가 있다.
select instr('Hello', 'l')
from dual;
-- 리턴값이 0이면 해당 글자가 없다.
select instr('Hello', 'w')
from dual;

-- padding: 5자리, 남은 자리는 *로 채운다.
-- 리턴하는 데이터 타입은 character
select lpad(salary, 5, '*')
from employees;

select rpad(salary, 5, '*')
from employees;

-- J라는 글자를 BL로 대치한다.
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- 해당 글자를 머리와 꼬리에서 뜯어낸다.
select trim('H' from 'Hello')
from dual;

-- 머리와 꼬리에 없으면 안 뜯어낸다.
select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

-- 과제: 위 query에서 ' '가 trim됐음을, 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

-- 기본값은 스페이스다. 생략 가능하다.
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
-- substr: 글자수를 생략하면 전체 선택
where substr(job_id, 4) = 'PROG';

-- 과제: 위 query에서, where절을 like로 refactoring하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제: 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--       이름의 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';

-- round function을 다뤄보자
-- 파라미터가 넘버인 것 / 2번째 파라미터는 소수점 2번째 자리를 나타낸다. 반올림할 자리를 나타낸다.
select round(45.926, 2)
from dual;

-- 2번째 파라미터 위치에서 내림 처리
select trunc(45.926, 2)
from dual;

-- 라운드로 정수를 표현하고 싶다. 올림처리해서 정수처리
select round(45.923, 0), round(45.923)
from dual;

-- 내림처리해서 정수처리
select trunc(45.926, 0), trunc(45.923)
from dual;

-- 과제: 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;

-- 오늘 날짜를 다루는 function. 업무에서 많이 사용된다. sysdate는 파라미터가 없다.
-- 출력 당시 날짜를 나타낸다. 가장 많이 쓰이는 single function
select sysdate
from dual;

select sysdate + 1
from dual;

select sysdate - 1
from dual;

-- 기간을 알아낼 수 있다. 날짜 간격.
select sysdate - sysdate
from dual;

-- 근속 기간을 알 수 있다.
select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 파라미터로 날짜값 2개를 받는다. 두 날짜 사이의 개월수를 나타내준다.
-- 앞의 날짜가 최근이다.
select months_between('2023/12/31', '2022/12/31')
from dual;

-- 두번째 파라미터의 개월수를 더해준다.
select add_months('2023/01/18', 3)
from dual;

-- (1 일요일..)5 목요일 / 1월 18일 이후로 첫번째 목요일을 나타낸다.
select next_day('2023/01/18', 5)
from dual;

select next_day('2023/01/18', 4)
from dual;

-- 숫자 말고 문자로도 표현할 수 있다.
select next_day('2023/01/18', 'thursday')
from dual;

-- 요일을 약자로
select next_day('2023/01/18', 'thu')
from dual;

-- 말일을 구하고 싶다.
select last_day('2023/01/18')
from dual;

-- 과제: 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--       월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

-- 과제: 사원들의 이름, 월급 그래프를 조회하라.
--       그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;