-- subquery
-- main query에서 response를 만들어 낸다.
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

-- Ernst와 같은 직업을 갖고 있고 더 많이 버는 사원을 찾는다.
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');

-- 과제: Kochhar에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');

-- 과제: IT부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'IT');

-- 과제: Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
--       이름 순으로 오름차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name != 'Abel'
order by last_name;

select last_name, salary
from employees
-- 에러: subquery에 리턴되는 값이 2개 이상이다. > 연산자는 좌우항 모두 하나씩만 있어야 한다.
where salary > (select salary
                from employees
                where last_name = 'King');

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- 과제: 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;

-- 에러: = 연산자는 좌우항 하나씩만 있어야 한다.
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id);

-- 고쳐보자.
select employee_id, last_name
from employees
where salary in (select min(salary)
                from employees
                group by department_id);

-- 과제: 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- 과제: 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);

-- subquery 리턴값이 여러 개일 때 쓰는 연산자
-- =any는 in과 뜻이 같다.
select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from departments
                    where location_id = 1700);

select employee_id, last_name, job_id, salary
from employees
-- <any는 9000 미만
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
-- <all은 4200미만
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- 과제: 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);

-- 과제: 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--       사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG');

-- subquery의 리턴값이 없을 때 (row가 없을 때)
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);

select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');

-- subquery에서 null을 리턴할 때: 문제가 안 된다. 버려진다.
-- in은 =any
select last_name
from employees
where employee_id in (select manager_id
                        from employees);

-- 결과가 없다.
-- not in은 <>all
select last_name
from employees
where employee_id not in (select manager_id
                            from employees);

-- 과제: 위 문장을 all 연산자로 refactoring하라.
select last_name
from employees
where employee_id <>all (select manager_id
                        from employees);

select count(*)
from departments;

-- exists: 존재하면 true고 존재하지 않으면 false다.
-- from 상품 테이블 exists..from 주문 테이블로 하여 주문된 적이 있는 것만 골라낼 수 있다.
select count(*)
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);

-- 과제: 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id);
