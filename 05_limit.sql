-- limit
-- 전체 행 조회
-- limit이 포함된 order by랑 단순 order by는 정렬 기준 컬럼의 값이 같으면
-- 약간의 순서 차이가 있을 수 있다.(추가적인 정렬 기준으로 조정 가능)
SELECT
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC;

-- 페이징 처리를 하기 위해 1~4은 1페이지, 5~7은 2페이지에 나오게 해야함.
-- 그렇게 하려면 5~7에 대한 자료에 접근을 할 수 있어야한다. -> 중간 행만 추출하는 방법은?
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC, menu_code DESC 
 LIMIT 4, 3; -- limit은 order by 절에 포함된 것이다. 보기 쉽게 하기 위해서 줄바꿈 / offset(시작위치), length(offset부터 원하는 개수)
-- 6개의 절이 존재. 위에서 말햇지만 order by 절 내부에 limit가 포함된다. 즉, limit는 새로운 절이 아니고 키워드임.
-- order by가 먼저 수행된 후에 limit가 수행된다.
-- limit을 하면 기존의 순서가 바뀔수도 있다.


SELECT 
		 *
  FROM tbl_menu
 ORDER BY menu_code LIMIT 10;
-- 시작 위치가 0번쨰 idx 부터 시작한다면 limit의 파라미터를 1개만 적어줘도 된다. -> 하나의 수치만 주면 length의 의미를 가짐.
-- limit은 페이징처리 or 요구하는 자료들만 추출할 때 사용



