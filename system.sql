alter user hr account unlock;
alter user hr identified by hr;

-- �տ� �ִ� you�� username, �ڿ� �ִ� you�� password
create user you identified by you;
-- role�� �ο��ؼ� ������ ��Ʈ�� �ο��� �� �ִ�.
grant connect, resource to you;

-- connect role
create session
-- resource role
create table ..