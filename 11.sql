-- view 객체를 다뤄보자.
-- 테이블을 부분적으로만 노출시키기 위해 사용한다.
-- data dictionary view를 이미 봤다.
-- view의 정체는 코드이다. 본질은 query이다. 따라서 그 안에는 데이터가 없다.
-- 테이블을 수정하는 것은 어렵지만 뷰를 수정하는 것은 간단하다. 코드이기 때문이다.

-- 80번 부서만 보고 싶다.
create view empvu80 as
    -- 노출시키고 싶은 data를 subquery로 작성한다.
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80

select * from empvu80;

select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);

create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;

desc empvu80

-- 과제: 50번 부서원들의 사번, 이름, 부서번호로 구성된 DEPT50 view를 만들어라.
--       view 구조는 EMPNO, EMPLOYEE, DEPTNO이다.
create or replace view DEPT50 as
    select employee_id EMPNO, last_name EMPLOYEE, department_id DEPTNO
    from employees
    where department_id = 50;
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50;

desc dept50
select * from dept50;

-- view에도 constraint를 걸 수 있다.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    -- 제약 조건을 걸기 위해 with check option을 붙인다.
    with check option constraint dept50_ck;

drop table teams;
create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;

create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50
values(300, 'Marketing');

select count(*) from teams;

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    -- where절의 조건을 검사한다.
    with check option;

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    -- insert update delete를 거부한다. select는 허용한다.
    with read only;

insert into empvu10 values(501, 'Abel', 'Sales');
select * from empvu10;

-- sequence를 다뤄보자.
-- 값을 순차적으로 뽑아내는 것이 역할이다.
drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 5;

create sequence x_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    -- 미리 준비시켜 놓는 작업이 cache이다.
    nocache
    -- 최고값 maxvalue에 도달한 뒤에 다시 start부터 시작할 것인가?
    nocycle;

select x_xid_seq.nextval from dual;

-- 과제: DEPT 테이블의 DEPARTMENT_ID 컬럼의 field value로 쓸 sequence를 만들어라.
--       sequence는 400 이상, 1000 이하로 생성한다. 10씩 증가한다.
drop sequence dept_deptid_seq;
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

-- 과제: 위 sequence를 이용해서, DEPT 테이블에서 Education 부서를 insert하라.
insert into dept(department_id, department_name)
values(
dept_deptid_seq.nextval, 'Education'
);
desc dept
select * from dept;

commit;

-- reference "복사하다"
-- index를 다뤄보자.
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

-- Oracle은 rowid로 각 row들을 구분한다. PK가 아니다.
select last_name, rowid
from employees;

-- index의 사용법과 비슷하다.
select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

-- 내 스키마에는 어떤 인덱스가 있는지 조회한다.
select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제: DEPT 테이블의 DEPARTMENT_NAME에 대해 index를 만들어라.
drop index dept_deptname_idx;
create index dept_deptname_idx
on dept(department_name);

-- synonym
-- 서로 명칭이 통일이 되지 않을 경우 사용한다.
drop synonym team;
create synonym team
for departments;

select * from team;

-- 과제: EMPLOYEES 테이블에 EMPS synonym을 만들어라.
drop synonym emps;
create synonym emps
for employees;
