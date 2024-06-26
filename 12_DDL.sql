/* DDL(Data Definition Language) */
-- 데이터가 들어갈 틀을 만드는 것
CREATE TABLE if NOT EXISTS tb1(
 pk INT PRIMARY KEY,
 fk INT,
 col1 VARCHAR(255),
 CHECK(col1 IN ('Y', 'N')) -- 체크 연산자를 사용해서 2개중에 하나인지 확인 가능
) ENGINE = INNODB;

-- 존재하는 테이블을 요약해서 확인가능
DESC tb1;
DESCRIBE tb1;

INSERT 
  INTO tb1
VALUES
(
  1, 2, 'Y'
);
-- 위 테이블을 만들었을때 auto increment를 안달았기 때문에 pk를 무조건 적어놔야함.

/* auto_increment == 값을 기억하는 번호발생기 */
/* drop */
DROP TABLE tb2;

CREATE TABLE tb2(
  pk INT PRIMARY KEY AUTO_INCREMENT,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE = INNODB;

DESC tb2;

INSERT 
  INTO tb2
VALUES
(
  NULL
 , 2
 , 'N'
);

SELECT * FROM tb2;


/* alter */ -- update 같은 느낌 -> ddl의 업데이트 (계정 비번 바꾸기, 테이블 컬럼 만들기 등)
-- 컬럼 추가
ALTER TABLE tb2 ADD col2 INT NOT NULL;
DESC tb2;

-- 컬럼 삭제
ALTER TABLE tb2 DROP COLUMN col2;
DESC tb2;

-- 컬럼 이름 및 컬럼 정의 변경 (alter는 보통 쓰면 안좋음. -> 모델링이 잘못된거)
ALTER TABLE tb2 CHANGE COLUMN fk change_fk INT NOT NULL;
DESC tb2;

-- 제약조건 제거(pk 제약조건 제거 도전)
-- 1. auto_increment 먼저 제거하라는 오류
ALTER TABLE tb2 DROP PRIMARY KEY;
-- 2. atuo_increment 제거
ALTER TABLE tb2 MODIFY pk INT;
DESC tb2;

-- 다시 pk 제거
ALTER TABLE tb2 DROP PRIMARY KEY;
DESC tb2;

-- pk나 nonull을 바꾸려면 DROP 아니라 MODIFY 해야한다.


-- 선생님께서 truncate에 대해 보고 한다고 하셨음.
/* truncate */ -- 절삭 의미 
CREATE TABLE if NOT EXISTS tb3(
  pk INT AUTO_INCREMENT,
  fk INT,
  col1 VARCHAR(255) CHECK(col1 IN ('Y', 'N')),
  PRIMARY KEY(pk)
);

DESC tb3; -- pk는 테이블당 1개?

SELECT * FROM tb3;

DROP TABLE tb3;

TRUNCATE TABLE tb3;




