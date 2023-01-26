-- 테이블을 만든 적이 없으므로 비어 있다.
select tname
from tab;

create table depts(
-- 제약조건 이름: 테이블명_컬럼명_pk 또는 fk
-- 제약조건은 테이블이 있어야 의미 있다. 종속적인 객체이다.
-- 제약조건 객체는 DB의 무결성을 확보하려고 쓰이는 것이다.
-- physical하게 참이라고 판단하는 기준: primary key는 유일해야 한다.
-- 각 테이블에는 Primary Key가 반드시 있어야 한다. 무결성을 확보하기 위해서이다.
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20)
);

-- metadata가 든 테이블인 data dictionary를 살펴보자.
desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
-- primary key는 not null과 unique 제약 조건을 더한 것이다. (기술적인 관점에서)
-- PK = not null + unique
employee_id number(3) primary key,
-- not null은 null만 빼고 중복된 값이 들어갈 수 있다.
-- "필수"라고 표시될 것이다. 업무 관점에서 "필수", 기술적인 관점에서는 not null 제약 조건이 걸려 있다.
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
-- check는 입력값에 조건을 건다. insert와 update 실행시에 검사된다.
-- 논리적으로 무결성을 검사하는 유일한 제약 조건이다.
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
-- 지금까지는 column level로 제약 조건을 설정했다. 그러나 table level로 제약 조건을 설정할 수도 있다.
-- field name을 괄호 안에 명시한다. 여기서는 email
-- field는 row의 관점, column은 table의 관점
constraint emps_email_uk unique(email),
-- foreign key는 간접적으로 relationship을 나타낸다. 관계를 나타내기 위해 필드 2개가 필요하다.
-- 무결성을 확보하기 위해서 만들어졌다. 업무상 존재하지 않는 데이터는 제외된다.
-- 참과 거짓을 판단하는 기준이 되는 data가 있으므로 다른 제약 조건보다 고급지다.
constraint emps_deptid_fk foreign key(department_id)
-- FK인 department_id는 depts 테이블의 department_id를 복사한다.
    references depts(department_id)
);

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
-- physical하게 즉 기술상/logical하게 즉 업무상
-- 501번 사원이 없다면 업무상 거짓이 된다. 거짓된 데이터를 막으려면 교육을 시켜야 한다.
-- 최근에는 사람을 교육시키는 대신 머신을 교육시키려고 한다. 머신 러닝.
insert into emps values(501, 'a', 'musk@gmail.net', 2000, 100);

-- 테이블을 없앨 때 제약조건도 같이 없애야 한다. 안 그러면 유령처럼 남는다.
-- 그러기 위해서 cascade constraints를 붙인다.
drop table emps cascade constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

-- hr로 스키마(사용자)를 바꾼다.
-- 테이블이 없다고 나온다.
-- you 스키마로 바꾼다.
-- 테이블이 나온다.
select * from depts;

-- system 유저로 바꾼다.
-- (10.sql에서 계속)