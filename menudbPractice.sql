select menu_code,
       menu_name,
       orderable_status
from tbl_menu
where
    orderable_status<> 'Y';  -- 같지않음

#true가 되는 조건
select 1 and 1;

#false가 되는 조건
select 1 and 0, 0 and 0, 0 and null;

#null이 되는 조건
select 1 and null, null and null;

#and가 or보다 우선순위가 높다
#괄호를 통해 우선순위 변경가능

#beetween연산자
#[column_name] between[A] and [B]

select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price >= 10000 and menu_price <=25000;

#beetween의 부정표현 경계값을 포함하지 않는다
select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price not between 10000 and 25000;

#like 연산, 찾아줌
select
    *
from
    tbl_menu
where
    menu_name like '%갈치%';

#in연산자의 부정표현
select menu_name,
       category_code
from tbl_menu
where category_code in (4, 5, 6); -- 4,5,6목록중에 없는 데이터만 조회

#distinct
-- 중복된 값을 제거하는데 사용됨

select
    distinct category_code
from
    tbl_menu
order by category_code;

-- null값 포함하고 잇는 컬럼에 distinct사용
-- null값도 종류로 취급되어 조회된다
select
    distinct ref_category_code
from
    tbl_category;

-- 다중열 distinct사용, 값들이 모두 동일하면 중복된것으로 판별함
select distinct
    category_code,
    orderable_status
from
tbl_menu;

-- select [columnName] from [tableName] limit [offset],[rowcount]
-- offset : 시작할 행의 번호 (인덱스 체계)
-- row_count : 이후 행부터 반환 받을 행의 갯수
-- tbl_menu 테이블의 menu_code, menu_name, menu_price

select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc
limit 5;

#alias 별칭달기
select a.menu_code as 'code',
       a.menu_name as name,
       a.menu_price price
from tbl_menu a
order by
    price;

#inner join
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
inner join tbl_category b
on a.category_code = b.category_code
order by b.category_code;

#using 컬럼명이 같을 경우
# using으로 서로 연관있는 컬럼에 대한 조건을 작성하여 join할수있따

select
    a.menu_name,
    b.category_name
from
    tbl_menu a
inner join tbl_category b using(category_code)
order by
    b.category_name;

# left join : 왼쪽과 일치하는 오른쪽테이블을 join해준다
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
left join tbl_category b on a.category_code=b.category_code;

#right join : 두번째 테이블을 모두 조회하고 오른쪽과 일치하는 왼쪽테이블을 join해준다
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
right join tbl_category b on a.category_code = b.category_code;

#cross join : 두테이블의 모든 가능한 조합을 반환하는 join
#카르테시안 곱이라고도함
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
cross join tbl_category b;

#self join : 같은 테이블 내에서 행과 행사이의 관계를 찾기위해 사용되는 join
select
    a.category_name 카테고리,
    b.category_name 대분류
from
    tbl_category a
join tbl_category b on a.ref_category_code=b.category_code;

#goruping
select category_code from tbl_menu group by category_code;

select category_code,sum(menu_price)
from tbl_menu group by category_code;

select menu_price,category_code
from tbl_menu group by menu_price,category_code
having category_code >=5 and category_code <=8 -- 그룹의 조건절
order by menu_price;

select category_code,sum(menu_price)
from tbl_menu group by category_code with rollup; -- 총합도 같이나옴

# 서브쿼리
select menu_code, menu_name, menu_price, orderable_status
from tbl_menu where category_code = (
    select category_code
    from tbl_menu
    where menu_name ='민트미역국'
    ); -- 서브쿼리실행시 미역국메뉴의 카테코리코드가 반환됨
      -- 반환된 코드로 메인쿼리에서 다시 실행됨

#다중행 서브쿼리
select max(menu_price) from tbl_menu;
select * from tbl_menu where menu_price >= all(
    select menu_price from tbl_menu
);

#exists
select a.category_code, a.category_name
from tbl_category a
where not exists(
    select category_code
    from tbl_menu b
    where b.category_code = a.category_code
);
#스칼라서브쿼리 : 반환행수가 1행보다 많을수없다
select a.menu_name,
       (select category_name
    from tbl_category b
    where b.category_code = a.category_code)
category_name
from tbl_menu a;

#cte(from 절에서만 사용가능)
-- 재귀공통테이블 표현식은 자체이름을 참조하는 하위 쿼리가 있는 표현식
with menucate as -- 임시저장공간(파생테이블) 만들어주기
    (select menu_name,category_name  -- 괄호안의 코드 먼저실행후에 반환된코드를
    from tbl_menu a join tbl_category b  -- 임시공간에 담겨진 메인코드와 함께 실행함
    on a.category_code = b.category_code)
select * from menucate order by menu_name;

#union : 두개이상 select결과문을 결합하여 중복제거후 반환
#union all : 중복제거 안하고 모두 반환
select * from tbl_menu where category_code =10
union select * from tbl_menu where menu_price < 9000;

#inner join(교집합)
select a.* from tbl_menu a inner join #2.모든열을 선택해서 서브쿼리 결과와 menu_code기준으로 조인함
 (select * from tbl_menu where menu_price <9000 #1.9000보다작은모든메뉴를 b에 담음
)b on(a.menu_code = b.menu_code) #3.9000보다 작은메뉴와 동일한memu_code만 선택됨
where a.category_code =10; #4.결과 : 메뉴가격이 9000보다 작고 카테코리코드가 10인것이 최종

select * from tbl_menu a
    where category_code =10 and menu_code in(
        select menu_code from tbl_menu where menu_price < 9000
        );  #위와 동일한 결과이지만 성늠면에서 더 좋음



#minus
-- 9000보다 작은얘들중에서 카테고리가 10인것만 선택함
select a.* from tbl_menu a -- tbl_menu의 모든행 a를 서브쿼리결과 b와 조인함
    left join(select * from tbl_menu where menu_price < 9000)
b on(a.menu_code = b.menu_code)
where a.category_code =10 and b.menu_code is null;
-- b.menu_code is null은 서브쿼리결과와 조인되지않은 a의 행을 선택함

#DML
select * from tbl_menu;

#insert into[테이블명] values[컬럼내용]..
insert into tbl_menu values (25,'바나나해장국',8500,4,'Y');