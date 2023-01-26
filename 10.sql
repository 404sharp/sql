drop table hire_dates;

-- 필드 value로 null을 넣는 방법: 필드에 null값을 명시하거나 insert into에서 해당 필드를 생략
create table hire_dates (
emp_id number(8),
-- 이 필드를 생략했을 때 default 값이 들어간다. default를 생략하면 default null이다.
hire_date date default sysdate);

-- DB의 구조는 테이블을 파악하는 것이 대부분이다.
-- 업무에 쓰지 않는 데이터는 메타데이터라고 부른다.
-- 데이터든 메타데이터든 다 테이블이다. 그러나 메타데이터를 갖고 있는 것은 data dictionary라고 한다.

-- data dictionary
select tname
from tab;

-- 과제: 위 테이블에서 쓰레기값(쓸모 없는 값)을 제외한 값들을 조회하라.
select tname
from tab
where tname not like 'BIN%';

-- 모든 필드값을 명시한다.
insert into hire_dates values(1, to_date('2025/12/21'));
-- 필드에 null값을 명시한다.
insert into hire_dates values(2, null);
-- 필드값을 생략한다. 필드는 default 값을 가진다.
insert into hire_dates(emp_id) values(3);

select * from hire_dates;

-- MS Word에서 저장 버튼 누르기가 커밋이다.
commit;

-- DB 관점에서 스키마는 HR 스키마, system 스키마 등이 있다. 테이블의 집합이다.
-- username으로 각각의 스키마를 구분한다. 새 스키마 = 새 DB 유저.
-- 스키마는 physical한 게 아니다. logical하게 있는 것이다.
-- 지구 관점에서 스키마는 아시아, 유럽, 아메리카 등이 있다.
-- 아시아 관점에서 스키마는 한국, 중국, 일본 등이 있다.
-- 스키마를 나누는 것은 데이터 처리 능력의 한계 때문이다.
-- 회사도 스키마다. 사람의 집합, 문화의 집합.

-- DML 수동 커밋, DDL 자동 커밋.

-- DCL (Data Control Language)
-- language의 형태를 띠었지만 실상은 command이다.
-- grant/revoke/deny 등.

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
-- 모든(all) 권한을 부여한다.
grant all on hr.departments to you;

-- you 유저로 바꾼다.
drop table employees cascade constraints;
create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
-- 다른 스키마의 테이블을 지정할 때는 스키마를 접두사로 붙인다.
department_id number(4) constraint emp_dept_fk references hr.departments(department_id)
);

-- 시 군 구 할 때의 "구"
create table gu (
-- PK를 갖고 있는 부모 테이블
gu_id number(3) primary key,
gu_name char(9) not null
);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
-- FK를 갖고 있는 자식 테이블
-- on delete cascade는 부모 테이블에서 데이터가 삭제될 때 같이 삭제되는 것을 의미한다.
gu_id number(3) references gu(gu_id) on delete cascade
);

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
-- on delete set null은 부모 테이블에서 데이터가 삭제될 때 null로 설정되는 것을 의미한다.
gu_id number(3) references gu(gu_id) on delete set null
);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;

create table a (
aid number(1) constraint a_aid_pk primary key
);

create table b (
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid)
);

insert into a values(1);
insert into b values(31, 1);
-- 9는 부모 테이블에서 복사한 값이 아니다. 에러이다.
insert into b values(32, 9);

-- FK를 재운다. (작동불능으로 만든다.)
-- 위의 문장을 쓸 수 있다.
alter table b disable constraint b_aid_fk;

-- FK를 활성화한다.
-- 활성화되고 자동으로 검사를 해보니 에러가 뜬다.
alter table b enable constraint b_aid_fk;
-- FK 활성화만 하고 검사를 하지 않게 한다.
alter table b enable novalidate constraint b_aid_fk;

-- FK가 활성화되어 있으므로 에러이다.
insert into b values(33, 8);

-- subquery; create table의 서브쿼리는 as를 쓴다.
create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

select * from sub_departments;

-- 테이블 구조 변경 실습
create table users(
user_id number(3)
);
desc users

alter table users add(user_name varchar2(10));
desc users

alter table users modify(user_name number(7));
desc users

alter table users drop column user_name;
desc users

insert into users values(1);

-- table을 read only로 만든다.
alter table users read only;
insert into users values(2);

-- table을 read/write로 만든다.
alter table users read write;
insert into users values(2);

commit;
