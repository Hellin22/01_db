-- group by절
-- 중복된걸 하나의 그룹으로 묶는다는 느낌 -> distinct와 비슷한 느낌  -> 하나의 절로써 해석됨.
-- 메뉴가 존재하는 카테고리 그룹 조회
SELECT
		 *
  FROM tbl_menu;


SELECT
		 category_code
  FROM tbl_menu
 GROUP BY category_code;
 
SELECT
		 DISTINCT category_code
  FROM tbl_menu; 
-- -> 그룹 함수를 적용하기 위해 group by를 사용함. == sum, avg, count, max, min 등등

-- count 함수 활용 -> *은 null 포함한 모든것의 개수 출력
SELECT 
		 COUNT(*) AS '카테고리의 개수'
	  , concat(a.category_code, '번 카테고리') as '카테고리 번호'
  FROM tbl_menu a
 GROUP BY a.category_code;
-- from, group by, select 순서로 실행
-- -> group by는 그룹별로 적용 -> 어떤 row에 대해서 그룹을 하고 다른 메뉴를 출력하라고 하면 문제가됨.
-- 즉, 저기서 a.menu_name 열을 같이 보여달라하면 1개가 대표메뉴로 나올텐데 이는 무의미하다.

-- count 함수
-- count(컬럼명 or *)
-- count(컬럼명) 해당 컬럼에 null이 아닌 행의 갯수
-- count(*) 모든 행의 개수
SELECT 
		 COUNT(*) AS 'null을 포함한 모든 카테고리 행'
	  , COUNT(ref_category_code) AS '상위 카테고리가 존재하는 카테고리'
  FROM tbl_category;

-- sum 함수 활용
SELECT
		 category_code
	  , COUNT(menu_price)
	  , menu_price
  FROM tbl_menu
 GROUP BY menu_price;
 -- 위에꺼는 내가 해본건데 category_code가 의미없는 값이 되는듯.

SELECT
		 category_code
	  , SUM(menu_price)
  FROM tbl_menu
 GROUP BY category_code;

-- avg 함수 활용
SELECT
		 category_code
	  , FLOOR(AVG(menu_price))
  FROM tbl_menu
 GROUP BY category_code;


-- havaing 절
-- 그룹에 대한 조건은
SELECT
		 SUM(menu_price) 
	  , COUNT(*)
  FROM tbl_menu
 GROUP BY category_code 
--  HAVING category_code BETWEEN 5 AND 9;
HAVING SUM(menu_price) > 20000;


SELECT 
		 category_code
	  , AVG(menu_price)
  FROM tbl_menu
 WHERE menu_price > 10000
 GROUP BY category_code
HAVING AVG(menu_price) > 12000 -- having절은 주로 그룹 함수 or 그룹 단위 조건
 ORDER BY 1 DESC;

-- ----------------------------------------
-- ROLLUP
-- group을 묶을 때 하나의 기준(하나의 컬럼)으로 그룹화 하여 roolup을 하면
-- 총 합계의 개념이 나온다.
SELECT 
		 COUNT(menu_price)
  	  , category_code
  FROM tbl_menu
 GROUP BY category_code
  WITH ROLLUP;
 -- gorup by를 쓸때에 select에 하나의 조건을 제외한 나머지 col은 무의미하다. 유의미한건 group의 재료로 사용했던게 그나마 유의미
 	
 
-- group을 묶을 때 여러개의 기준(여러개의 컬럼)으로 그룹화하여 rollup
SELECT
		 COUNT(menu_price)
	  , menu_price
	  , category_code
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP; 
 
SELECT
		 *
  FROM tbl_menu
 GROUP BY menu_name;
