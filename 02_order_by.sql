-- order by(정렬)

-- 오름차순(Ascending, ASC)
-- 내림차순(Descending, DESC)
SELECT
	    menu_code
	  , menu_name
	  , menu_price 
  FROM tbl_menu; -- 데이터가 들어간 순서대로 result set 생성
  
SELECT
	    menu_code
	  , menu_name
	  , menu_price 
  FROM tbl_menu
--  ORDER BY menu_price ASC;
--  ORDER BY menu_price ASC, menu_name DESC; -- 우선순위를 나누어 정렬할 수도 있다
 ORDER BY 3 ASC, 2 DESC;							-- select 절의 컬럼 순번으로 정렬 가능 (자주 사용)
