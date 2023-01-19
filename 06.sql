-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equijoin
-- 공통 컬럼을 먼저 찾는다. 그리고 같은(=)(그래서 equijoin) 데이터가 있는 row끼리 결합한다.
-- 여기서는 location_id가 같은 row끼리 결합한다. 나머지는 버린다.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- 공통 컬럼을 내가 코드상에 드러낸다.
select employee_id, last_name, department_id, location_id
from employees join departments
-- 공통 컬럼을 using에 명시한다. department_id만 같으면 join된다.
using (department_id);

-- 과제: 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
-- departments 테이블에 department_id가 null이 있더라도 = 연산에서 true가 나오지 않으므로 join되지 않는다.
where department_id is null;

-- natural join은 테이블상의 모든 공통 컬럼을 사용한다. 그래서 결과가 32행이다.
-- 따라서 department_id와 manager_id가 같아야 join된다.
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
-- 에러
where d.location_id = 1400;

-- 에러: using에 쓰는 컬럼에는 접두사를 붙이지 않는다.
select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;