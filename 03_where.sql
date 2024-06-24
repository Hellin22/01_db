-- where절
-- 주문가능한 메뉴만 조회(메뉴이름, 메뉴가격, 주문가능상태)

SELECT
  		 *
  FROM tbl_menu;
  
SELECT
		 menu_name
	  , menu_price
	  , orderable_status
  FROM tbl_menu
 WHERE orderable_status = 'y'; -- where는 언제 호출? select, from 다음에 where이 오는건가?? -> from, where, select
-- WHERE orderable_status = 'n';

-- DESC (describe)를 통해서 컬럼명 빠르게 확인 + 칼럼의 제약조건을 알 수 있다.
DESC tbl_menu;

-- --------------------------------------------------------------------------
-- '기타' 카테고리에 해당하지 않는 메뉴를 조회하시오.
-- 1) 카테고리명이 '기타'인 카테고리는 카테고리 코드가 10번이다. -> fk가 카테고리 코드이기 때문. -> join을 활용하면 한번에 해결 가능
SELECT
		 *
  FROM tbl_category
 WHERE category_name = '기타';

-- 2) 카테고리 코드가 10번이 아닌 메뉴 조회 -> 기타가 아닌 10번을 조건으로 해야한다. (실제로 erd를 자세히 보고 알아야 한다.)
SELECT
		 *
  FROM tbl_menu
--  WHERE category_code != 10
 WHERE category_code <> 10;
-- ORDER BY category_code DESC;
 
-- where 절은 조건을 나타내는데 같은지(=)와 같지 않은지(!=, <>)를 사용할 수 있다.
-- + 대소비교(>, <, >=, <=)를 통해 값을 추출할 수 있다. 
SELECT 
		 *
  FROM tbl_menu
 WHERE menu_price >= 5000
 ORDER BY menu_price ASC;
 
-- 5000원 이상 이면서 7000원 미만인 메뉴 조회
SELECT 
		 *
  FROM tbl_menu
 WHERE menu_price >= 5000 
   AND menu_price < 7000;
 
-- 10000원 보다 크거나 5000원 이하인 메뉴 조회
SELECT 
		 *
  FROM tbl_menu
 WHERE menu_price > 10000 
    OR menu_price <= 5000;
    
-- where절은 from절 다음으로 실행. -> 21개의 row에 대해서 where 절을 수행한다.
-- where 절은 2가지가 존재. 앞선 1가지 조건이 충족되지 않을시에는 다음 조건은 조회하지 않는다?
--
--
--
--
--
--
--
-- ---------------------------------------------------------------
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price > 5000
 	 OR category_code = 10;
 	 
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price > 5000
 	AND category_code = 10;
 	
-- --------------------------------------------------------
-- between 연산자 활용하기 -> AND 연산자를 좀더 편하게 사용하는 방법
-- between은 (<=, >= 인 경우에만 사용) -> (<, >인 경우 menu_price != 5000을 추가로 적어줘야 하기 때문)
-- 가격이 5000원 이상이면서 9000원 이하인 메뉴 전체 컬럼 조회
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price >= 5000
   AND menu_price <= 9000;
   
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price BETWEEN 5000 AND 9000;

-- 반대 범위도 테스트(5000 미만 또는(OR) 9000 초과)
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price NOT BETWEEN 5000 AND 9000;
 
-- ------------------------------------------------------ where절은 행의 개수만큼 진행되게 된다!
-- like문
-- 제목, 작성자 등을 검색할 때 사용
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name LIKE '%밥%'; 
-- %는 와일드카드. %밥 = ~~밥 의미, 밥% = 밥~~의미. %밥% = ~밥~ 의미 == 밥이라는 단어 포함된 모든 단어
-- 보통 앞 뒤로 와일드카드를 붙여서 포함된 단어를 찾는다. 
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name not LIKE '%밥%';
 

-- -----------------------------------------------------
-- in 연산자 -> 여러번 반복되는 or문을 줄여준다.
SELECT 
		 *
  FROM tbl_menu
 WHERE category_code = 5
    OR category_code = 8
    OR category_code = 10;
    
SELECT
		 *
  FROM tbl_menu
 WHERE category_code IN (5, 8, 10);
 
SELECT 
		 *
  FROM tbl_menu
 WHERE category_code NOT IN (5, 8, 10);


-- ------------------------------------------------------------
-- is null 연산자 확인 (null은 대입 연산으로 찾을 수 없음.)
SELECT 
		 *
  FROM tbl_category
 WHERE ref_category_code IS NULL;
 
 SELECT 
		 *
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL;