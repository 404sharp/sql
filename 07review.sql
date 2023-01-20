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
