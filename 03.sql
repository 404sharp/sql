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
-- lower function의 리턴값과 상수를 비교한다.
where lower(last_name) = 'higgins';

select concat('Hello', 'World')
from dual;

-- 하나의 row, 세 개의 field를 파라미터로 받는다.
-- 2번째 글자부터 시작해서 5개의 글자를 뽑아낸다.
select substr('HelloWorld', 2, 5)
from dual;

-- 음수값은 방향이 왼쪽이다.
select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

-- 해당하는 글자가 어느 위치에 있는가
-- 왼쪽에서 3번째
-- 리턴값이 0보다 크면 해당 글자가 있다.
select instr('Hello', 'l')
from dual;
-- 리턴값이 0이면 해당 글자가 없다.
select instr('Hello', 'w')
from dual;

-- padding: 5자리, 남은 자리는 *로 채운다.
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
