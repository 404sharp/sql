-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
-- 공통 컬럼을 먼저 찾는다. 그리고 같은(=)(그래서 equi join) 데이터가 있는 row끼리 결합한다.
-- 여기서는 location_id가 같은 row끼리 결합한다. 나머지는 버린다.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- 공통 컬럼을 내가 코드상에 드러낸다.
select employee_id, last_name, department_id, location_id
from employees join departments
-- 공통 컬럼을 using의 괄호 안에 명시한다. department_id만 같으면 join된다.
using (department_id);

-- 과제: 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
-- departments 테이블에 department_id가 null이 있더라도 = 연산에서 true가 나오지 않으므로 join되지 않는다.
where department_id is null;

-- natural join은 테이블상의 모든 공통 컬럼을 사용한다. 그래서 결과가 32행이다.
-- 따라서 department_id와 manager_id가 같아야 join된다. (table model을 보면 그 둘이 공통이다.)
select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
-- 각 테이블에서 location_id가 1400인 row만 골라서 join한다.
where location_id = 1400;

-- 테이블명에 약자를 쓸 수 있다.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
-- 에러: using에 쓰인 컬럼에는 접두사를 붙이지 않는다.
where d.location_id = 1400;

-- 에러: using에 쓰인 컬럼에는 접두사를 붙이지 않는다.
select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
-- using에 쓰이지 않은 공통 컬럼에는 접두사를 붙여야 한다.
where d.manager_id = 100;

-- = 연산자를 드러낸다.
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id;

-- 3개 이상의 table을 join한다.
select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제: 위 query를 using으로 refactoring하라.
select employee_id, city, department_name
from employees e join departments d
-- using을 쓰면 = 연산자를 명시하지 않는다.
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
-- 149가 상사인 사원들을 골라낸다.
where e.manager_id = 149;

-- 과제: Toronto에 위치한 부서에서 일하는 사원들의
--       이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name, e.job_id, e.department_id, 
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join
-- programmer만큼 돈 받는 사원들을 찾는다.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- self join
-- 하나의 테이블에 있는 row들끼리 join한다.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager_last_name mgr
from employees worker join employees manager
-- 에러: 논리적 테이블이라서 접두사를 생략하면 명확성을 잃는다.
on manager_id = employee_id;

-- 에러: 논리적 테이블이라서 접두사를 생략하면 명확성을 잃는다.
select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- 과제: 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료명을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id
order by 1, 2, 3;

-- 과제: Davies보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees x
on x.last_name = 'Davies'
and e.hire_date > x.hire_date;

-- 과제: 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저 입사일을 조회하라.
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join
select e.last_name, e.department_id, d.department_name
-- Grant가 나타난다.
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
-- 사람이 없는 부서가 나타난다.
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
-- left와 right의 효과가 모두 나타난다.
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제: 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--       King 회장도 테이블에 포함하라.
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;

-- 옛날 문법
-- inner join + equi join
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

-- 과거 문법
-- 3개 테이블 join
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

-- 과거 문법
-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- 널이 있을 곳에 (+)를 붙인다. 널이 왼쪽에 있으므로 right outer join
where e.department_id(+) = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- 널이 오른쪽에 있으므로 left outer join
where e.department_id = d.department_id(+);

select e.last_name, e.department_id, d.department_name
from employees e, departments d
-- full outer join은 없다.
where e.department_id(+) = d.department_id(+);

select worker.last_name || ' works for ' || manager.last_name
-- self join
from employees worker, employees manager
where worker.manager_id = manager.employee_id;