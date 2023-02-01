-- mybatis 유저가 접속이 끊겨 있어야 실행된다. 즉 mybatis 유저는 이 문장을 실행할 수 없다.
-- cascade로 지정해서 유저가 삭제될 때 데이터도 같이 삭제되도록 한다.
drop user mybatis cascade;

-- 테이블 이름 앞에 mybatis 유저(스키마)를 지정한다. 이 문장들은 system 스키마로 실행될 것이다.
create table mybatis.users (
    user_id number(2) constraint user_userid_pk primary key,
    user_name varchar2(12),
    reg_date date
);

create table mybatis.addresses (
    user_id number(2) constraint addr_userid_pk primary key
                    constraint addr_userid_fk references mybatis.users(user_id),
    address varchar2(30)
);

create table mybatis.posts (
    post_id number(3) constraint post_postid_pk primary key,
    post_title varchar2(60),
    post_content varchar2(120),
    user_id number(2) constraint post_userid_fk references mybatis.users(user_id)
);
