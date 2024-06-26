/* Transaction */

-- autocommit 비활성화
SET autocommit = 0;
SET autocommit = OFF;

-- autocommit 활성화
SET autocommit = 1;
SET autocommit = ON;

START TRANSACTION;

INSERT 
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);

UPDATE tbl_menu
	SET menu_name = '수정된메뉴'
 WHERE menu_code = 5;

SELECT * FROM tbl_menu;

ROLLBACK;

SELECT * FROM tbl_menu;





















