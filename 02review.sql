-- where -- boolean 타입의 expression을 받는다.
select employee_id, last_name, department_id
from employees
where department_id = 50;

-- 과제: 176번 사원의 사번, 이름, 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

-- statement는 대소문자를 구분하지 않지만 data('Whalen')는 대소문자를 구분한다.
select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

-- 과제: 월 $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

-- 같지 않다: !=
select last_name, job_id
from employees
where job_id != 'IT_PROG';

-- 범위를 표현할 때 between A and B
select last_name, salary
from employees
where salary between 2500 and 3500;

-- 문자로 범위를 표현해 본다.
select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제: 'King' 사원의 first_name, last_name, 직업, 월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

-- 날짜로 범위를 표현해 본다.
select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

-- 실선은 between, 점선은 in
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

-- in을 or로 표현해 본다.
select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;

select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');

-- like 연산자(비슷하다 = 같다 + 다르다)
-- 검색에서 활용한다.
select last_name
from employees
-- 대문자 S로 시작하는 last_name을 찾아라.
where last_name like 'S%';

select last_name
from employees
-- r로 끝나는 last_name을 찾아라.
where last_name like '%r';

-- 과제: 이름에 s가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%s%';

-- 과제: 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';