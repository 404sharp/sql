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
