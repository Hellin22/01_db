SELECT 
		 menu_name
	  , category_name
  FROM tbl_menu
  JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;
  
-- -----------------------------------------------------------------------------------
-- 1. from절 없는 select 해보기
SELECT 7 + 3;
SELECT 10*534;
SELECT 6 % 3, 6 % 4;
SELECT NOW();
SELECT CONCAT('유', ' ', '관순');

SELECT CONCAT('메뉴 이름은 : ', menu_name) FROM tbl_menu;
SELECT CONCAT('메뉴 이름은 : ', 'adsads') FROM tbl_menu;
SELECT CONCAT('메뉴 이름은 : ', menu_name, '이고 가격은 ', menu_price) FROM tbl_menu;

-- 별칭(alias) 달아보기
SELECT 7+3 AS '합', 10*2 AS '곱';
SELECT NOW() AS '현재 시간';
SELECT 7+3 AS '합입니다.'; -- 별칭에 특수기호가 있다면 싱글쿼테이션(')을 반드시 추가한다. ('합입니다.' == 합입니다)

-- -----------------------------------------------------------------------------------