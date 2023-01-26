drop table hire_dates;

-- �ʵ� value�� null�� �ִ� ���: �ʵ忡 null���� ����ϰų� insert into���� �ش� �ʵ带 ����
create table hire_dates (
emp_id number(8),
-- �� �ʵ带 �������� �� default ���� ����. default�� �����ϸ� default null�̴�.
hire_date date default sysdate);

-- DB�� ������ ���̺��� �ľ��ϴ� ���� ��κ��̴�.
-- ������ ���� �ʴ� �����ʹ� ��Ÿ�����Ͷ�� �θ���.
-- �����͵� ��Ÿ�����͵� �� ���̺��̴�. �׷��� ��Ÿ�����͸� ���� �ִ� ���� data dictionary��� �Ѵ�.

-- data dictionary
select tname
from tab;

-- ����: �� ���̺��� �����Ⱚ(���� ���� ��)�� ������ ������ ��ȸ�϶�.
select tname
from tab
where tname not like 'BIN%';

-- ��� �ʵ尪�� ����Ѵ�.
insert into hire_dates values(1, to_date('2025/12/21'));
-- �ʵ忡 null���� ����Ѵ�.
insert into hire_dates values(2, null);
-- �ʵ尪�� �����Ѵ�. �ʵ�� default ���� ������.
insert into hire_dates(emp_id) values(3);

select * from hire_dates;

-- MS Word���� ���� ��ư �����Ⱑ Ŀ���̴�.
commit;

-- DB �������� ��Ű���� HR ��Ű��, system ��Ű�� ���� �ִ�. ���̺��� �����̴�.
-- username���� ������ ��Ű���� �����Ѵ�. �� ��Ű�� = �� DB ����.
-- ��Ű���� physical�� �� �ƴϴ�. logical�ϰ� �ִ� ���̴�.
-- ���� �������� ��Ű���� �ƽþ�, ����, �Ƹ޸�ī ���� �ִ�.
-- �ƽþ� �������� ��Ű���� �ѱ�, �߱�, �Ϻ� ���� �ִ�.
-- ��Ű���� ������ ���� ������ ó�� �ɷ��� �Ѱ� �����̴�.
-- ȸ�絵 ��Ű����. ����� ����, ��ȭ�� ����.

-- DML ���� Ŀ��, DDL �ڵ� Ŀ��.

-- DCL (Data Control Language)
-- language�� ���¸� ������� �ǻ��� command�̴�.
-- grant/revoke/deny ��.

-- ���̺��� ���� ���� �����Ƿ� ��� �ִ�.
select tname
from tab;

create table depts(
-- �������� �̸�: ���̺��_�÷���_pk �Ǵ� fk
-- ���������� ���̺��� �־�� �ǹ� �ִ�. �������� ��ü�̴�.
-- �������� ��ü�� DB�� ���Ἲ�� Ȯ���Ϸ��� ���̴� ���̴�.
-- physical�ϰ� ���̶�� �Ǵ��ϴ� ����: primary key�� �����ؾ� �Ѵ�.
-- �� ���̺��� Primary Key�� �ݵ�� �־�� �Ѵ�. ���Ἲ�� Ȯ���ϱ� ���ؼ��̴�.
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20)
);

-- metadata�� �� ���̺��� data dictionary�� ���캸��.
desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
-- primary key�� not null�� unique ���� ������ ���� ���̴�. (������� ��������)
-- PK = not null + unique
employee_id number(3) primary key,
-- not null�� null�� ���� �ߺ��� ���� �� �� �ִ�.
-- "�ʼ�"��� ǥ�õ� ���̴�. ���� �������� "�ʼ�", ������� ���������� not null ���� ������ �ɷ� �ִ�.
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
-- check�� �Է°��� ������ �Ǵ�. insert�� update ����ÿ� �˻�ȴ�.
-- �������� ���Ἲ�� �˻��ϴ� ������ ���� �����̴�.
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
-- ���ݱ����� column level�� ���� ������ �����ߴ�. �׷��� table level�� ���� ������ ������ ���� �ִ�.
-- field name�� ��ȣ �ȿ� ����Ѵ�. ���⼭�� email
-- field�� row�� ����, column�� table�� ����
constraint emps_email_uk unique(email),
-- foreign key�� ���������� relationship�� ��Ÿ����. ���踦 ��Ÿ���� ���� �ʵ� 2���� �ʿ��ϴ�.
-- ���Ἲ�� Ȯ���ϱ� ���ؼ� ���������. ������ �������� �ʴ� �����ʹ� ���ܵȴ�.
-- ���� ������ �Ǵ��ϴ� ������ �Ǵ� data�� �����Ƿ� �ٸ� ���� ���Ǻ��� �������.
constraint emps_deptid_fk foreign key(department_id)
-- FK�� department_id�� depts ���̺��� department_id�� �����Ѵ�.
    references depts(department_id)
);

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
-- physical�ϰ� �� �����/logical�ϰ� �� ������
-- 501�� ����� ���ٸ� ������ ������ �ȴ�. ������ �����͸� �������� ������ ���Ѿ� �Ѵ�.
-- �ֱٿ��� ����� ������Ű�� ��� �ӽ��� ������Ű���� �Ѵ�. �ӽ� ����.
insert into emps values(501, 'a', 'musk@gmail.net', 2000, 100);

-- ���̺��� ���� �� �������ǵ� ���� ���־� �Ѵ�. �� �׷��� ����ó�� ���´�.
-- �׷��� ���ؼ� cascade constraints�� ���δ�.
drop table emps cascade constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

-- hr�� ��Ű��(�����)�� �ٲ۴�.
-- ���̺��� ���ٰ� ���´�.
-- you ��Ű���� �ٲ۴�.
-- ���̺��� ���´�.
select * from depts;

-- system ������ �ٲ۴�.
-- ���(all) ������ �ο��Ѵ�.
grant all on hr.departments to you;

-- you ������ �ٲ۴�.
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
-- �ٸ� ��Ű���� ���̺��� ������ ���� ��Ű���� ���λ�� ���δ�.
department_id number(4) constraint emp_dept_fk references hr.departments(department_id)
);

-- �� �� �� �� ���� "��"
create table gu (
-- PK�� ���� �ִ� �θ� ���̺�
gu_id number(3) primary key,
gu_name char(9) not null
);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
-- FK�� ���� �ִ� �ڽ� ���̺�
-- on delete cascade�� �θ� ���̺��� �����Ͱ� ������ �� ���� �����Ǵ� ���� �ǹ��Ѵ�.
gu_id number(3) references gu(gu_id) on delete cascade
);

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
-- on delete set null�� �θ� ���̺��� �����Ͱ� ������ �� null�� �����Ǵ� ���� �ǹ��Ѵ�.
gu_id number(3) references gu(gu_id) on delete set null
);

insert into gu values(100, '������');
insert into gu values(200, '�����');

insert into dong values(5000, '�б�����', null);
insert into dong values(5001, '�Ｚ��', 100);
insert into dong values(5002, '���ﵿ', 100);
insert into dong values(6001, '��赿', 200);
insert into dong values(6002, '�߰赿', 200);

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
-- 9�� �θ� ���̺��� ������ ���� �ƴϴ�. �����̴�.
insert into b values(32, 9);

-- FK�� ����. (�۵��Ҵ����� �����.)
-- ���� ������ �� �� �ִ�.
alter table b disable constraint b_aid_fk;

-- FK�� Ȱ��ȭ�Ѵ�.
-- Ȱ��ȭ�ǰ� �ڵ����� �˻縦 �غ��� ������ ���.
alter table b enable constraint b_aid_fk;
-- FK Ȱ��ȭ�� �ϰ� �˻縦 ���� �ʰ� �Ѵ�.
alter table b enable novalidate constraint b_aid_fk;

-- FK�� Ȱ��ȭ�Ǿ� �����Ƿ� �����̴�.
insert into b values(33, 8);

-- subquery; create table�� ���������� as�� ����.
create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

select * from sub_departments;

-- ���̺� ���� ���� �ǽ�
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

-- table�� read only�� �����.
alter table users read only;
insert into users values(2);

-- table�� read/write�� �����.
alter table users read write;
insert into users values(2);

commit;
