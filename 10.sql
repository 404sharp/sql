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
