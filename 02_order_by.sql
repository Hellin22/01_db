-- order by(정렬)

-- 오름차순(Ascending, ASC)
-- 내림차순(Descending, DESC)
SELECT
	    menu_code
	  , menu_name
	  , menu_price 
  FROM tbl_menu; -- 데이터가 들어간 순서대로 result set 생성
  
SELECT
	    menu_code 			-- 1번째
	  , menu_name			-- 2번째
	  , menu_price 		-- 3번째
  FROM tbl_menu
--  ORDER BY menu_price ASC;
--  ORDER BY menu_price ASC, menu_name DESC; 	-- 우선순위를 나누어 정렬할 수도 있다
--  ORDER BY 3 ASC, 2 DESC;							-- select 절의 컬럼 순번으로 정렬 가능 (자주 사용) -> *을 쓰는게 안좋은 이유중 하나
--  ORDER BY 3, 2 DESC;									-- ORDER BY의 default는 ASC이기 때문에 생략 가능.
 ORDER BY 3 DESC, 2;
 
-- 별칭을 이용한 정렬
SELECT
		 menu_code AS '메뉴코드'  			-- AS와 ' '는 생략가능 하지만 최대한 붙여주기
	  , menu_name AS 'mn'
	  , menu_price AS 'mp'
  FROM tbl_menu
 ORDER BY mp DESC;					-- 싱글 쿼테이션 생략 불가 -> 별칭에 특수기호 사용 
 -- 여기에 왜 별칭을 사용할수있는가? select, from이 끝난 후에 order by가 실행된다.
 -- 따라서 이미 col명은 별칭으로 바뀌었기 때문에 가능하다. -> 왜 내림차순으로 안되지??????
 
-- -----------------------------------------------------------------------------
-- mariadb는 field 함수를 활용해서 정렬이 가능하다.
SELECT FIELD('a', 'b', 'c', 'd'); 
SELECT FIELD('a', 'b', 'a', 'd'); 
SELECT FIELD('a', 'aadsf', 'aasdf', 'asf');  -- 좌측에 있는 값이 우측의 배열에서 몇번째에 나오는가가 나온다.

SELECT
		 orderable_status
	  , field(orderable_status, 'N', 'Y')
  FROM tbl_menu;
  
-- field를 활용한 order by
-- 주문 가능한것 부터 보이게 정렬
SELECT
		 menu_name
	  , orderable_status AS 'dd.'
  FROM tbl_menu
 ORDER BY FIELD('dd.', 'N', 'Y') DESC; -- 숫자로 바꾸고 싶은 곳을 field에 넣으면 됨. -> .을 썼기 때문에 ' '을 사용해야함.
 
 
-- -------------------------------------------------------------------
SELECT * FROM tbl_category; -- null은 어떡하냐?
-- null 값(비어 있는 컬럼 값)에 대한 정렬
-- 1) 오름차순 시 : null 값이 먼저 나옴
SELECT
		 *
  FROM tbl_category
 ORDER BY ref_category_code ASC;
 
-- 2) 내림차순 시 : null 값이 나중에 나옴
SELECT
		 *
  FROM tbl_category
 ORDER BY ref_category_code DESC;
 
-- 3) 오름차순에서 null이 나중에 나오도록 바꿈
SELECT
		 *
  FROM tbl_category
 ORDER BY -ref_category_code DESC; -- desc를 통해 null을 나중으로 보내고 '-'로 desc와 반대로 진행 == asc

-- 4) 내림차순에서 null이 먼저 나오도록 바꿈
SELECT
		 *
  FROM tbl_category
 ORDER BY -ref_category_code ASC; -- ASC를 하면 NULL이 처음에 나온다. 이에 따라 null이 먼저 나오고 '-' 때문에 내림차순으로 나온다.


 
 
 
 
 