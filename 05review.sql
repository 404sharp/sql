-- group function
-- 파라미터로 row들이 그룹지어 들어온다.
-- call되는 횟수는 group의 갯수에 비례한다.
-- 리턴되는 row의 갯수는 하나(single function과 동일)
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- 날짜에 대해서도 min과 max는 쓸 수 있다.
-- min은 옛날, max는 최근
-- Oracle은 날짜를 long 타입의 숫자로 관리
select min(hire_date), max(hire_date)
from employees;

-- 과제: 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

-- 업무에 많이 쓸 함수 count: row의 갯수를 세다
-- *로 모든 컬럼을 지정할 수 있다.
select count(*)
from employees;

-- 과제: 70번 부서원이 몇 명인지 조회하라.
select count(*)
from employees
where department_id = 70;

-- *를 쓰기 싫다면 PK (primary key)를 지정하면 안전하다. null이 없기 때문이다.
select count(employee_id)
from employees;

-- 그룹 함수는 null을 무시한다.
select count(manager_id)
from employees;

-- 영업 사원들의 평균 커미션율
select avg(commission_pct)
from employees;

-- 과제: 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;

-- 중복되는 것도 받는다. all이 생략되어 있다.
select avg(all salary)
from employees;

-- 중복되는 것을 제외한다.
select avg(distinct salary)
from employees;

-- 과제: 직원이 배치된 부서 갯수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제: 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;

-- select절에 컬럼 네임이 등장하면 group by를 써야 한다. 그룹의 제목이기 때문이다.
-- count문은 그룹의 갯수(12)만큼 call된다.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- 그룹의 제목은 department_id, job_id
-- employee_id는 PK이므로 그룹 안의 모든 row가 카운팅된다.
select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- 과제: 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

-- 일부 row를 골라내듯이 일부 group을 골라내고 싶다.
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

-- having에서는 alias를 쓸 수 없다.
select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;

select department_id, max(salary)
from employees
-- row를 골라낸다. having department_id > 50과 같은 효과
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
-- where절에는 single function만 가능, group function 불가
where max(salary) > 10000
group by department_id;

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
-- having절에는 group function 가능; 조건절에 group function을 포함시키고 싶다면 having절 사용
having sum(salary) > 13000
order by payroll;

-- 과제: 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--       최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
-- 2번째 컬럼으로 정렬
order by 2 desc;
