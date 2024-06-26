-- subqueries

-- '민트미역국'의 카테고리 번호를 조회
SELECT * FROM tbl_menu;

SELECT
		 a.category_code
  FROM tbl_menu a
 WHERE a.menu_name = '민트미역국'; -- 4
 
 -- '민트미역국'과 같은 카테고리의 메뉴를 조회
SELECT
		 menu_name
  FROM tbl_menu
 WHERE category_code = 4;
 
 SELECT
		 menu_name
	  , category_code
  FROM tbl_menu
 WHERE category_code = (SELECT a.category_code
								  FROM tbl_menu a
								 WHERE a.menu_name = '민트미역국');
 
-- 결과가 1개만 나오면 where 절에 나올 수 있다. (단일 행, 단일 열)

-- 다중행 다중열 ==> from 절에 주로 들어간다.
-- 다중 행 단일열 / 단일 행 다중 열 이렇게도 할 수 있다.

-- 서브쿼리의 종류
-- 1) 다중행 다중열 서브쿼리
SELECT
		 *
  FROM tbl_menu;
  
-- 2) 다중행 단일열 서브쿼기
SELECT
		 menu_name
  FROM tbl_menu;
  
-- 3) 단일행 다중열 서브쿼리
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';

-- 4) 단일행 단일열 서브쿼리
SELECT 
		 category_code
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';
 
 
-- 가장 많은 메뉴가 포함된 카테고리에 메뉴 개수 
-- 1. 가장 많은 메뉴는?
SELECT
		*
  FROM tbl_menu;
  
SELECT
		 COUNT(category_code) AS ct
	  , category_code
  FROM tbl_menu
 GROUP BY category_code;

-- 위에서 ct가 제일 큰 category_code를 찾으면 된다.

SELECT 
		 MAX(ct), category_code
  FROM (SELECT COUNT(category_code) AS ct, category_code
  			 FROM tbl_menu
 		   GROUP BY category_code) AS a;


SELECT 
	    COUNT(*) AS 'count'-- '카테고리별 메뉴 갯수'
  FROM tbl_menu
 GROUP BY category_code;
 
 
SELECT 
		 MAX(a.count)
  	  , a.category_code -- 이거 아니랫는데 왜?
  FROM(SELECT COUNT(*) AS 'count'
  				, category_code
  			FROM tbl_menu
 		  GROUP BY category_code) a;
 		  -- 마리아 디비는 from 절에 subquery를 넣을때 무조건 별칭을 달아야 한다.
 		  -- 그리고 a.count가 아니라 COUNT(*)라고 작성하면 안된다.
-- 선행해서 쿼리에서 동작해야할 쿼리를 서브쿼리로 작성한다. ->  from절 안에 들어있는거
-- mariadb에서는 서브쿼리를 from절에 사용 시(인라인 뷰)에는 반드시 별칭을 달아야한다. (-> a)menudbinformation_schema
-- 서브 쿼리의 그룹 함수의 결과를 메인 쿼리에서 쓰기 위해서는 반드시 별칭을 달아야 한다. (-> count)
  

USE menudb;
/* 상관 서브쿼리 */
-- 메인쿼리를 활용한 서브쿼리라면 상관(메인쿼리와 서브쿼리의 상관관계 활용) 
-- 서브쿼리라고 한다.
-- 메뉴가 존재하는 카테고리 별로 평균 구하기 -> group by로도 작성 가능. sub query, 상관 서브쿼리를 사용해서도 하는것.
SELECT 
		 AVG(menu_price)
  FROM tbl_menu
 WHERE category_code = 4;


-- 메뉴별 각 메뉴가 속한 카테고리의 평균보다 높은 가격의 메뉴들만 조회
-- -> 작동 과정은 a 테이블에서 한 행을 가져옴. 이때 where 처음에 나온 menu_price는 a.menu_price? == 맞음
-- 그 후에 그 행의 category_code를 가지고 와서 b의 모든 행을 보면서 b.category_code가 a와 같은 행을 찾아서 avg를 구한다.
-- 이때 서브쿼리가 끝나고 결론을 말하면
-- a의 한 행과 같은 b의 모든 카테고리 코드를 보고 같은것들의 b menuprice가 나오고. 이 b의 avg를 a의 한 행과 비교해서
-- a가 더 높은거만 출력한다. -> 즉, 이 문제는 테이블에서 내 카테고리의 평균보다 큰거만을 모두 구하는것.
-- -> category_code가 1인 평균이 25라고 하자. 이때 1번행의 category_code가 1이었고 price가 20이었다. 그러면 날라가는것.
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu AS a
 WHERE a.menu_price > (SELECT AVG(b.menu_price)
 							    FROM tbl_menu b
 						   	WHERE b.category_code = a.category_code);
-- 메인쿼리의 변화가 서브쿼리의 변화에 영향을 준다.
-- -> 똑같은 테이블을 사용했다는 뜻인가?????

/* EXISTS */
-- 서브쿼리의 결과가 없으면 false, 있으면 true -> where절에서 사용
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- 카테고리 중에 메뉴에 부여된 카테고리들의 카테고리 이름 조회
SELECT
		 category_name
	  , category_code
  FROM tbl_category AS a
 WHERE EXISTS (SELECT menu_code
 					  FROM tbl_menu AS b
 					 WHERE a.category_code = b.category_code) -- -> subquery는 b이므로 b가 where절에 먼저 나와야 하나? 그건 아닌듯.
 ORDER BY category_code ASC;
-- 연결이 안되어 있는 카테고리 ex)식사 같은 상위 카테고리 or 빵류 같은 메뉴가 없으면 빵은 카테고리가 없음 == 연결이 안되어있음.


