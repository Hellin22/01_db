/* constraint */ -- 제약조건
-- 제약조건이란? 데이터 무결성 정합성을 지키기 위한 디비의 노력
/* 1. not null 제약조건 */
-- null값을 포함할 수 없는 컬럼에 대한 제약조건이자 컬럼 레벨에서만 제약조건 적용 가능
-- --> 이 말이 뭐냐면 제일 밑에 테이블 레벨에서 null을 적용하는게 안된다는거임.
DROP TABLE if EXISTS user_notnull;
CREATE TABLE if NOT EXISTS user_notnull(
  user_no INT NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255)
) ENGINE = INNODB;

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');
(2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(3, 'user03', 'pass03', null, '남', '010-1234-5678', 'hong123@gmail.com');



/* 2. unique 제약조건 */
-- 중복값이 들어가지 않도록 하는 제약조건
-- 컬럼레벨 및 테이블레벨 모두 가능하다. -> 변수(컬럼명) 옆에 바로 쓰든, 마지막에 unique를 작성하든 상관없다는 뜻 
DROP TABLE if EXISTS user_unique;
DESC user_unique;
CREATE TABLE if NOT EXISTS user_unique(
  user_no INT NOT NULL UNIQUE,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone)
) ENGINE = INNODB;

INSERT 
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');
(2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');


INSERT 
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(2, 'user03', 'pass01', '홍길동2', '남', '010-1234-5678', 'hong123@gmail.com'); -- 전화번호는 unique -> null이라 fail


/* 3. primary key 제약조건 */
-- not null + unique 제약조건이라고 볼 수 있다. 
-- 모든 테이블은 pk를 무조건 가져야한다.(2개 이상 제약조건을 할 수는 없다.) 


DROP TABLE if EXISTS user_primarykey;
DESC user_primarykey;
CREATE TABLE if NOT EXISTS user_primarykey(
  user_no INT,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone),
  PRIMARY KEY(user_no)
) ENGINE = INNODB;

DESC user_primarykey;

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');
(2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');


INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES 
(1, 'user012', 'pass012', '홍길동1', '남', '010-1234-52678', 'hong112323@gmail.com');


/* 4. foreign key 제약조건 */
-- 4-1. 회원등급 부모 테이블 먼저 생성
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade(
  grade_code INT NOT NULL UNIQUE,
  grade_name VARCHAR(255) NOT NULL
);

-- 4-2. 회원 자식 테이블 을 이후에 생성
DROP TABLE If EXISTS user_foreignkey1;
CREATE TABLE if NOT EXISTS user_foreignkey1 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT, -- 자료형은 user_grade하고 일치시켜야함.
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
) ENGINE = INNODB;


INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

INSERT
  INTO user_foreignkey1
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-111-2222', 'hong@gmail.com', 10),
(2, 'user02', 'pass02', '동동동', '여', '010-1232131-23', 'aewfawe@gmail.com', 20);


-- foreign key 제약조건이 걸린 컬럼은 부모테이블의 pk값 + null값 까지 들어갈 수 있다. -> not null을 해버리면 null도 못온다.
-- foreign key가 null이면 어캐됨?
INSERT
  INTO user_foreignkey1
VALUES 
(3, 'user01', 'pass01', '홍길동', '남', '010-111-2222', 'hong@gmail.com', NULL);

-- foreign key로 부모 역할인 user_grade에 없는 값을 넣으면 어떻게 될까?
INSERT
  INTO user_foreignkey1
VALUES 
(4, 'user02', 'pass02', '동동동', '여', '010-1232131-23', 'aewfawe@gmail.com', 40);
-- Cannot add or update a child row: a foreign key constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`)) */
-- 즉, null은 되는데 부모에 없는값은 사용 못한다.

-- 10번 등급의 회원이 이미 존재해서 10번 등급은 삭제 불가 (참조 ㅇ)
DELETE 
  FROM user_grade
 WHERE grade_code = 10;
 
 -- 30번 등급의 회원은 존재하지 않아 30번 등급은 삭제 가능 (참조 x)
DELETE 
  FROM user_grade
 WHERE grade_code = 30;
SELECT * FROM user_grade;


-- 4-3. 삭제룰을 적용한 foreign key 제약조건 작성 
DROP TABLE If EXISTS user_foreignkey2;
CREATE TABLE if NOT EXISTS user_foreignkey2 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT, -- 자료형은 user_grade하고 일치시켜야함.
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code) 
  ON DELETE SET NULL -- set null 대신에 cascade를 쓸 수도 있는데 비추
  -- on delete = 내가 참조하고 있는 값이 사라진다면
) ENGINE = INNODB;


INSERT
  INTO user_foreignkey2
VALUES 
(1, 'user01', 'pass01', '홍길동', '남', '010-111-2222', 'hong@gmail.com', 10);

-- 삭제룰이 없는 자식이 있어서 자식의 데이터를 제거해 방해를 없앰.
TRUNCATE user_foreignkey1;

-- 현재 회원의 참조 컬럼값 확인
SELECT * FROM user_foreignkey2;

-- 참조하는 부모 테이블의 행 삭제 후 참조 컬럼 값 확인
DELETE FROM user_grade WHERE grade_code = 10;
SELECT * FROM user_foreignkey2;


SELECT *
FROM tbl_order_menu;