/* index */ -- 색인 -- 빠른 검색을 위한 것
SELECT * FROM tbl_menu;

CREATE TABLE phone (
  phone_code INT PRIMARY KEY,
  phone_name VARCHAR(100),
  phone_price DECIMAL(10, 2)
) ENGINE INNODB;

INSERT 
  INTO phone
VALUES 
(1, 'galaxyS24', 1200000),
(2, 'iphone14pro', 1430000),
(3, 'galaxyfold3', 1730000);

SELECT * FROM phone;


-- where절을 활용한 단순 조회
SELECT * FROM phone WHERE phone_name = 'galaxyS24';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';


-- phone_name에 index 추가하기
CREATE INDEX idx_name ON phone(phone_name);
SHOW INDEX FROM phone;


-- 다시 index가 추가된 컬럼으로 조회해서 index를 태웠는지 확인
SELECT * FROM phone WHERE phone_name = 'galaxyS24';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';


-- rebuild 개념 인덱스를 다시 다는 행위 / 약 1달에 한번
-- pk가 아닌데 index로 추가되었다면 rebuild를 주기적으로 해줘야함.
-- (mariadb는 optimize 키워드를 사용한다.)
OPTIMIZE TABLE phone;

DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;
