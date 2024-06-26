/* DML(Data Manipulation Language) */

-- insert, update, delete, select (DQL)

/* insert */
-- 새로운 행을 추가하는 구문이다.
-- 테이블 행의 수가 증가한다.
SELECT * FROM tbl_menu;
INSERT 
  INTO tbl_menu -- 테이블 칼럼에 넣을건지 적기 -> 기존 테이블 그대로 쓰면 생략함.
(
  menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  '초콜릿죽'
, 6500
, 7
, 'Y'
); -- auto incremnt 때문에 menu_code를 안적어준다면 그냥 마지막 번호 +1을 해서 테이블에 넣는다.
-- --> 유지보수 측면에서는 insert into 뒤에 칼럼명 적어주는게 좋음. == 알아보기 쉬워서. 없는 값은 null을 적어줘야한다.
SELECT * FROM tbl_menu ORDER BY 1 DESC;


/* multi insert */
INSERT 
  INTO tbl_menu
VALUES
(NULL, '참치맛아이스크림', 1700, 12, 'Y'), -- 코딩컨벤션의 허용 + 여러개 한꺼번에 insert 가능
(NULL, '멸치맛아이스크림', 1500, 11, 'Y');

INSERT INTO tbl_menu VALUES(NULL, '소시지맛커피', 2500, 8, 'Y');

/* UPDATE */ -- --> insert into  a values / update a set
-- 테이블에 기록된 컬럼값을 수정하는 구문
-- 기존 행을 수정하는 거니까 전체 행 개수에는 변화가 없다.
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name = '소시지맛커피';
 
UPDATE tbl_menu
	SET category_code = 7
 WHERE menu_code = 27;
-- 현재 상태는 commit을 안해서 roll back을 하면 되돌릴 수 있는 상태. 


-- subquery를 활용한 update
UPDATE tbl_menu 
	SET category_code = 6
 WHERE menu_code = (SELECT menu_code
 							 FROM tbl_menu
 							WHERE menu_name = '소시지맛커피');
 	-- 여기서 where절의 subquery에 '='을 사용했음. -> sub의 결과가 단일행 이었기 때문이다. (menu_code만 볼건데 그 행이 1개라서 결국 행, 열 1개씩이라 그럼)



/* DELETE */
-- 테이블의 행을 삭제
-- 테이블 행의 개수가 줄어든다. (영향을 받았다면)
SELECT * FROM tbl_menu ORDER BY 1 DESC;
-- delect는 컬럼이 필요가 없는데 왜냐하면 행 자체를 모두 지우는거기 때문이다. 그러면 행 전체를 지우는게 아닌 행, 열 1개의 자료만을 없앨 수는 없나?
DELETE
  FROM tbl_menu;
  
ROLLBACK;

-- mysql or mariadb는 autocommit이 기본적으로 'on'이라 insert, update, delete를 할때 base table(메모리)에 바로 반영된다.
-- 다시 살리고 싶다면 autocommit을 꺼주고 rollback을 하면 된다. -> autocommit을 한다는 것은 자동으로 commit
SET autocommit = OFF;