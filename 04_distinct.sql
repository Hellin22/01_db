-- distinct -> 칼럼에 교유한 데이터가 몇개 있는지를 보여준다.
SELECT
		 category_code
  FROM tbl_menu
 ORDER BY category_code;
 
-- 메뉴가 할당된 카테고리의 종류 -> 예를들어 카테고리 7이 결과가 안나오면 7번 카테고리(음료)는 아직 준비가 안된것.
SELECT
		 DISTINCT category_code
  FROM tbl_menu
 ORDER BY category_code;


-- 상위 카테고리 조회하기 -> ref 가테고리가 없는 카테고리 = 최상위 카테고리
-- 1) where절 활용
SELECT
		 *
  FROM tbl_category
 WHERE ref_category_code IS NULL;

-- 2)아래 코드를 통해 카테고리의 상위 카테고리 번호를 알 수 있다.
--   여기서 null이 왜 나오는거지? -> 이건 내가 수업에 집중을 못해서 그런듯. 좀 알아보기
--   생각해보니 당연하다. 왜냐하면 최상위 category_code라면 ref하는 category_code가 없을 것이기 때문이다.
--   따라서 최상위 카테고리는 ref하는 카테고리가 없을 것이다. == null -> 따라서 null이 나오게 된다.
-- WHERE ref_category_code is not null을 쓰면 null을 빼고 나온다.
SELECT 
			 DISTINCT ref_category_code
--   	  , category_name AS '카테고리명'
  FROM tbl_category;

-- 추후 배울 예정이지만 서브 쿼리를 활용하면 
-- 하나의 쿼리로 작성할 수 있다. 
-- -> in을 통해 sub query를 사용했다. 이때 1, 2, 3을 쿼리 대신 적어도 되지만 개발자는 이렇게 해야한다.
-- 이걸 하는 이유는 1, 1, 1, 2, 2, 3, 2, 2, ... 이런식으로 엄청 긴 값이 in 안에 들어가면 비효율적이므로 1, 2, 3만 쓰거나
-- 서브쿼리를 사용한다.
SELECT 
		 *
  FROM tbl_category
 WHERE category_code IN (SELECT DISTINCT ref_category_code 
 										 FROM tbl_category
 										WHERE ref_category_code IS NOT NULL
 									 );



-- 다중 열(칼럼이 여러개인것) distinct -> distinct를 여러개의 다중열에 적용하면 칼럼을 세트 단위★로 적용해서 본다.
-- 그러면 한개의 칼럼에만 적용하고싶다면? -> 그런게 이게 가능한가?
-- distinct는 중복되지 않는 값을 추출하는건데 서로 중복되지 않게 추출하는건 불가능하다. 애초에 말 자체가 잘못된것.
-- distinct는 여러개의 열에 한꺼번에 적용된다. 즉, 3개의 열에 하면 3개의 열을 세트로 적용한다.
SELECT 
		 category_code
	  , orderable_status
  FROM tbl_menu;

SELECT 
		 DISTINCT
		 category_code
	  , orderable_status
  FROM tbl_menu;



