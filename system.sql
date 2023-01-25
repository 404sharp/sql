alter user hr account unlock;
alter user hr identified by hr;

-- 앞에 있는 you는 username, 뒤에 있는 you는 password
create user you identified by you;
-- role을 부여해서 권한을 세트로 부여할 수 있다.
grant connect, resource to you;

-- connect role
create session
-- resource role
create table ..