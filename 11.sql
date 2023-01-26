-- view ��ü�� �ٷﺸ��.
-- ���̺��� �κ������θ� �����Ű�� ���� ����Ѵ�.
-- data dictionary view�� �̹� �ô�.
-- view�� ��ü�� �ڵ��̴�. ������ query�̴�. ���� �� �ȿ��� �����Ͱ� ����.
-- ���̺��� �����ϴ� ���� ������� �並 �����ϴ� ���� �����ϴ�. �ڵ��̱� �����̴�.

-- 80�� �μ��� ���� �ʹ�.
create view empvu80 as
    -- �����Ű�� ���� data�� subquery�� �ۼ��Ѵ�.
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

-- ����: 50�� �μ������� ���, �̸�, �μ���ȣ�� ������ DEPT50 view�� ������.
--       view ������ EMPNO, EMPLOYEE, DEPTNO�̴�.
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

-- view���� constraint�� �� �� �ִ�.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    -- ���� ������ �ɱ� ���� with check option�� ���δ�.
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
    -- where���� ������ �˻��Ѵ�.
    with check option;

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    -- insert update delete�� �ź��Ѵ�. select�� ����Ѵ�.
    with read only;

insert into empvu10 values(501, 'Abel', 'Sales');
select * from empvu10;

-- sequence�� �ٷﺸ��.
-- ���� ���������� �̾Ƴ��� ���� �����̴�.
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
    -- �̸� �غ���� ���� �۾��� cache�̴�.
    nocache
    -- �ְ� maxvalue�� ������ �ڿ� �ٽ� start���� ������ ���ΰ�?
    nocycle;

select x_xid_seq.nextval from dual;

-- ����: DEPT ���̺��� DEPARTMENT_ID �÷��� field value�� �� sequence�� ������.
--       sequence�� 400 �̻�, 1000 ���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
drop sequence dept_deptid_seq;
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

-- ����: �� sequence�� �̿��ؼ�, DEPT ���̺��� Education �μ��� insert�϶�.
insert into dept(department_id, department_name)
values(
dept_deptid_seq.nextval, 'Education'
);
desc dept
select * from dept;

commit;

-- reference "�����ϴ�"
-- index�� �ٷﺸ��.
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

-- Oracle�� rowid�� �� row���� �����Ѵ�. PK�� �ƴϴ�.
select last_name, rowid
from employees;

-- index�� ������ ����ϴ�.
select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

-- �� ��Ű������ � �ε����� �ִ��� ��ȸ�Ѵ�.
select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����: DEPT ���̺��� DEPARTMENT_NAME�� ���� index�� ������.
drop index dept_deptname_idx;
create index dept_deptname_idx
on dept(department_name);

-- synonym
-- ���� ��Ī�� ������ ���� ���� ��� ����Ѵ�.
drop synonym team;
create synonym team
for departments;

select * from team;

-- ����: EMPLOYEES ���̺� EMPS synonym�� ������.
drop synonym emps;
create synonym emps
for employees;
