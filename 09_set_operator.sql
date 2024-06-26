/* set operator */
-- set은 집합. 집합 연산자 -> join과의 차이는 무엇일까? join은 가로로 붙이는거. 즉, 열이 늘어나는데 set은 세로로 붙이는거임. 행을 늘림.
USE menudb;
/* UNION */
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10;

SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
 -- union 적용
 SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
UNION
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;

-- WHERE절 사용
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000 OR category_code = 10;
 
-- 검산
-- AND를 통해서 교집합을 하나 빼주는거기 때문에 WHERE의 AND를 사용해서 하나 빼주기
-- --> 그러면 set은 행이 늘어나는 거니까 같은 테이블을 조회한 결과를 적용해야하나? 즉, select가 같은 경우에만? 아직 모름ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ
-- --> UNION은 중복을 없앰. 집합이라 생각하기. -> WHERE절로 해도 되는거 맞음. 그런데 차집합 이런거도 구할 수 있따. 이게 SET OP의 목적인듯'?


/* UNION ALL */ -- --> UNION은 중복 없애고 적용했는데 UNION ALL은 그냥 붙여버리는것. == CROSS JOIN과 같다고 생각
 SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
UNION ALL
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
 
/* INTERSECT */
-- MYSQL과 MARIADB는 INTERSECT가 공식적으로 지원되지 않는다. (사용은 되는데 키워드(파란색)으로 뜨지가 않는 문제)
-- 1) inner join + sub query
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu AS a
 INNER JOIN (SELECT b.menu_code
						, b.menu_name
						, b.menu_price
						, b.category_code
						, b.orderable_status
				   FROM tbl_menu b
				  WHERE b.menu_price < 9000) AS c ON (a.menu_code = c.menu_code)
 WHERE a.category_code = 10;
 -- from절에 join이 있으니까 본문의 where 실행 전에 join 먼저 하는것.

-- 2) in연산자 활용
SELECT 
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu AS a
 WHERE a.category_code = 10
   AND a.menu_code IN (SELECT b.menu_code
   							 FROM tbl_menu b
   							WHERE b.menu_price < 9000);
   							
-- in 다음에는 숫자만 가능한가????  -> 결과는 다중행 서브쿼리가 나옴. -> =을 사용 못한다. 따라서 IN을 사용(여러개 올수있으니까)

/* MINUS */ -- 차집합
-- --> where절을 빼고 확인해보기
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
	  , c.*
  FROM tbl_menu AS a
  LEFT JOIN (SELECT b.menu_code
						, b.menu_name
						, b.menu_price
						, b.category_code
						, b.orderable_status
				   FROM tbl_menu b
				  WHERE b.menu_price < 9000) AS c ON (a.menu_code = c.menu_code)



SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu AS a
  LEFT JOIN (SELECT b.menu_code
						, b.menu_name
						, b.menu_price
						, b.category_code
						, b.orderable_status
				   FROM tbl_menu b
				  WHERE b.menu_price < 9000) AS c ON (a.menu_code = c.menu_code)
				  -- 여기까지만 실행시키면 NULL이 있는걸 볼 수 있음. + select에 c.* 해주기
 WHERE a.category_code = 10
 	AND c.menu_code IS NULL;

