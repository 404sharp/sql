-- set
-- set에는 중복된 값이 저장되지 않는다. set에는 키가 없기 때문이다.
-- list는 키가 있으므로 value가 중복되어도 구분이 가능하다.
-- 테이블은 set이다. 중복되는 것을 방지하기 위해 PK가 있는 것이다.

-- 합집합
-- 컬럼의 갯수와 데이터 타입이 같아야 한다.
select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
-- 중복을 제거하지 않는다. 176, 200번이 2개씩 있다.
union all
select employee_id, job_id
from job_history
order by employee_id;

-- 과제: 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
-- 답안1
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id
                    and e.job_id = j.job_id);
-- 답안2
select employee_id, last_name, job_id
from employees e
where e.job_id in (select job_id
                    from job_history j
                    where e.employee_id = j.employee_id);
-- 답안3
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;