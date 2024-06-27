-- type casting
-- 명시적 형변환

-- 1) 숫자 -> 숫자
SELECT CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격평균'
  FROM tbl_menu;
DESC tbl_menu;

-- 소수점 이하 한자리 까지만 표기할 수도 있다.
SELECT CAST(AVG(menu_price) AS FLOAT) AS '가격평균'
  FROM tbl_menu;

-- 소수점 이하 12자리까 도 표기할 수 있다.
SELECT CAST(AVG(menu_price) AS DOUBLE) AS '가격평균'
  FROM tbl_menu;


-- 2) 문자 -> 날짜
-- 2024년 6월 27일을 date형으로 변환
SELECT CAST('2024627' AS DATE);
SELECT CAST('2024@6@27' AS DATE);


-- 3) 숫자 -> 문자
SELECT CONCAT(1000, '원');
SELECT CONCAT(CAST(1000 AS CHAR), '원');


-- 암시적 형변환
SELECT 1 + '2'; 
SELECT 1 + CAST('2' AS INT);
SELECT 1 + '김'; -- mariadb가 연산시 치환하기 힘든 문자열은 0으로 치환하여 적용한다.
SELECT 5 > '반가워'; -- '반가워'가 0으로 치환 됨(true는 1, false는 0)
SELECT 0 = '반가워';
SELECT 0 = '반가워2'; 
SELECT 2 = '2반가워';



SELECT RAND(), FLOOR(RAND() * (11-1)+1);


