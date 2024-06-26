-- join -> from 절의 일부이다.

-- alias(별칭) -> from 절에 별칭을 다는 방법
-- 별칭 이제 무조건 붙이자.
-- 테이블 또는 from 절에 별칭을 추가할 때는 싱글쿼테이션(') 달면 안된다.
SELECT
		 a.category_code AS B
	  , a.menu_name
  FROM tbl_menu AS a -- AS 생략 가능
 ORDER BY a.category_code, a.menu_name;


-- inner join
-- inner 키워드 생략한 join도 inner join이다.
-- 1) on을 활용
SELECT
		 a.menu_name
	  , b.category_name
	  , a.category_code
	  , b.category_code
  FROM tbl_menu a
--  INNER JOIN tbl_category b ON a.category_code = b.category_code;
  JOIN tbl_category b ON a.category_code = b.category_code;
-- 나는 메뉴를 보고싶은데 (메뉴가 우선) 메뉴의 카테고리 이름도 보고싶어.
-- join은 테이블을 붙이는 거구나!!

-- 2) using 활용 (권장x) -> join을 할 테이블의 매핑 컬럼명이 동일한 경우 사용가능
SELECT
		 a.menu_name
	  , b.category_name
	  , a.category_code
	  , b.category_code
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code); 

-- left join, right join -> 어떤걸 기준으로 조인을 진행할건지 의미.

-- outer join -> 매핑이 안되더라도 비어있다면 null 값이 있게 join하기 (2개를 join한다고 하면 둘중 하나의 기준으로 진행)
-- 1) left join
SELECT
		 a.category_name
	  , b.menu_name
  FROM tbl_category a
  LEFT JOIN tbl_menu b ON (a.category_code = b.category_code);
  -- left join은 기존과 동일한것. 왼쪽을 기준으로 진행.


-- 2) right join
SELECT
		 a.menu_name
	  , b.category_name
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON (a.category_code = b.category_code);


-- 3) cross join -> 조건 무시하고 행*행의 개수만큼 나옴. 
SELECT
		 a.menu_name
	  , b.category_name
  FROM tbl_menu a
 CROSS JOIN tbl_category b;
 
 
-- 4) self join
-- a에 해당하는 것은 하위 카테고리, b에 해당하는 것은 상위 카테고리
SELECT 
		 a.category_code
	  , b.category_code
	  , b.category_name
  FROM tbl_category a
  JOIN tbl_category b ON(a.ref_category_code = b.category_code)

 