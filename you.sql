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
-- (10.sql���� ���)