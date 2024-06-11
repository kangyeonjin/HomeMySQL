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


