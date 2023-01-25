drop table dept;

-- create: data definition language (DDL) -- 하나의 객체를 만든다.
-- DDL은 auto commit이다.
create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);

create table emp (
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8, 2),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4)
);

-- dept라는 데이터 타입은 컬럼(필드)이 4개 있다.
insert into dept(department_id, department_name, manager_id, location_id)
values (100, 'Public Relation', 100, 1700);

-- 컬럼(필드) 갯수와 데이터 타입은 일치해야 한다.
insert into dept(department_id, department_name)
values(310, 'Purchasing');

-- 데이터가 잘 들어갔는지 확인한다.
select *
from dept;

-- transaction을 끝내기
-- commit을 하면 다른 클라이언트에서도 조회된다.
-- read consistency 읽기 일관성
commit;

insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values(300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate,
        'AC_ACCOUNT', 6900, null,
        205, 110);

-- 컬럼 네임을 생략한다. desc table을 했을 때의 순서대로 나열한다.
insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-637-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 310);

commit;

select * from emp;

-- 업무에 필요한 데이터를 만들기 위해 테이블이라는 데이터 타입을 제작하는 것이다.
-- table name은 복수형으로 만든다.
create table sa_reps (
rep_id number(6),
rep_name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2)
);

-- 한꺼번에 여러 개의 데이터를 insert
insert all
    into sa_reps values(1, '최한석', 20000, .1)
    into sa_reps values(2, '한아름', 30000, .12)
-- 문법 맞추기
select * from dual;

commit;

select * from sa_reps;

-- 이 코드 조각을 procedure라고 부른다. 알고리즘의 집합이다.
-- function과의 공통점: 알고리즘의 집합/차이점: 프로시저는 이름이 없다. 펑션은 이름이 있다.
-- 따라서 function은 재사용 가능. n번 사용 가능.
-- 변수 선언
declare
    base number(6) := 400;
begin
    for i in 1..10 loop
        -- i의 scope
        insert into sa_reps(rep_id, rep_name, salary, commission_pct)
        values (base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
-- 프로시저의 끝(?)
/

select *
from sa_reps
where rep_id > 400;

commit;

insert into sa_reps(rep_id, rep_name, salary, commission_pct)
    -- 데이터 타입이 같아야 한다. 업무상이 아니라 기술상으로 동일해야 한다.
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';

commit;

-- update를 다뤄보자.
-- emp 타입을 가진 데이터를 업데이트한다.
update emp
set job_id = 'IT_PROG',
    salary = 30000
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

update emp
-- 월급을 안 받고 일한다.
set salary = null
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

-- 마지막 commit 시점으로 되돌린다.
-- transaction을 끝내는 두 방법 중 하나다. 다른 하나는 commit이다.
rollback;

select job_id, salary
from emp
where employee_id = 300;

-- 기존의 데이터를 이용할 때 subquery를 사용한다.
update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    -- 중복되어 나쁜 코드
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback;

select job_id, salary
from emp
where employee_id = 300;

-- 위의 중복된 코드를 깔끔하게 바꿔보자.
update emp
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

commit;

-- 현장에서는 row의 갯수를 비교해서 refactoring이 제대로 되었는지 확인한다.

-- delete를 다뤄보자.
-- where가 없다면 dept 안의 모든 row를 없앤다.
delete dept
where department_id = 310;

select * from dept;

rollback;

select * from dept;

delete emp
where department_id = (
    select department_id
    from dept
    where department_name = 'Purchasing');

select * from emp;

commit;

-- 마지막 commit 후에 insert update delete 하면 transaction이 시작된다.
-- commit으로 transaction이 끝난다. rollback으로 transaction이 취소된다.
