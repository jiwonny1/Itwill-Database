/*-----------------------------------------------
<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
-----------------------------------------------
컬럼의 기본 데이타 타입(문자열, 숫자, 날짜)
- VARCHAR2(n) : 문자열 가변길이
- CHAR(n) : 문자열 고정길이
- NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
    예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
- DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
================================*/

CREATE TABLE TEST(
    NUM NUMBER (5, 2),--숫자타입 전체자리수 5 : 정수부3, 소수부2
    STR1 CHAR(10), --고정길이 문자열
    STR VARCHAR2(10), --가변길이 문자열
    DATE1 DATE --날짜데이터 : 년월일시분초
);
SELECT * FROM TEST;
INSERT INTO TEST VALUES (100.454, 'ABC','ABC', SYSDATE);
INSERT INTO TEST VALUES (100.455, 'ABC','ABC', SYSDATE);
INSERT INTO TEST VALUES (100.456, 'ABC','ABC', SYSDATE);
COMMIT;

--오류발생 : 정수부 3자리 저장 가능한데 4자리 저장을 시도하면 오류가 발생한다
INSERT INTO TEST VALUES (1234.456, 'ABC','ABC', SYSDATE);

INSERT INTO TEST VALUES (100.456, 'ABC','ABCDE', SYSDATE);
COMMIT;
SELECT * FROM TEST;

--문자열붙이기 부호(||) 사용
SELECT '-' || STR1 || '-', '-' || STR2 || '-' FROM TEST;
SELECT STR1, LENGTHB(STR1), STR2, LENGTHB(STR2) FROM TEST;
--------------------------------
SELECT * FROM TEST WHERE STR1 = STR2; --조회된 데이터 없음
SELECT * FROM TEST WHERE STR1 = 'ABC'; --오라클에서는 조회됨
SELECT * FROM TEST WHERE STR1 = 'ABC        '; --모든 DB에서 조회됨
SELECT * FROM TEST WHERE STR1 = 'ABC   '; --오라클에서는 조회됨
------------------------
--숫자타입 
SELECT * FROM TEST WHERE NUM = 100.45; --NUMBER VS NUMBER
SELECT * FROM TEST WHERE NUM = '100.45'; --오라클 조회됨 NUMBER VS 문자
SELECT * FROM TEST WHERE NUM = '100.45AAAA'; --ORA-01722: invalid number
-------------------
INSERT INTO TEST (STR1, STR2) VALUES ('1234567890', '1234567890');
SELECT * FROM TEST WHERE STR1 = STR2;
SELECT '-'||STR1 ||'-', '-'|| STR2 ||'-' FROM TEST;
SELECT STR1, LENGTHB(STR1), STR2, LENGTHB(STR2) FROM TEST;
-----------------
SELECT *FROM TEST;
SELECT DATE1, TO_CHAR (DATE1, 'YYYY-MM-DD HH24:MI:SS')FROM TEST;
SELECT DATE1, TO_CHAR (DATE1, 'YYYY/MM/DD HH24:MI:SS')FROM TEST;
-- '20230808112035' : 2023년 08월08일 11시 20분 35초
--=================================
--한글데이터 처리(UTF-8) : ASCII 코드 1byte, 한글 1글자 3byte사용
SELECT *FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ABCDEFGHIJ');
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '홍길동'); --한글 3글자*3 = 9byte
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '대한민국');
--SQL 오류: ORA-12899: value too large for column "MYSTUDY"."TEST"."STR2" (actual: 12, maximum: 10)
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '대한민국'); --한글4글자 * 3 = 12

--=============================
/* *** NULL(널)의 특성 *****
-- NULL(널) : 데이터가 없는 상태
-- NULL 은 비교처리가 안됨 : =, <>, !=, >, <, >=, <= 비교처리 의미 없음 - 결과 NULL
-- NULL 과의 연산결과는 항상 NULL(연산 의미 없음)
-- NULL 값에 대한 조회(검색)는 IS NULL, IS NOT NULL 키워드로 처리
--------------------- */
SELECT * FROM TEST;
SELECT * FROM TEST WHERE NUM = NULL; --조회안됨(비교연산 의미없음, 하지말것)
SELECT * FROM TEST WHERE NUM IS NULL; -- IS NULL 사용 검색할 것

SELECT * FROM TEST WHERE NUM <> NULL; --조회안됨(비교연산 의미없음, 하지말것)
SELECT * FROM TEST WHERE NUM IS NOT NULL; -- IS NOT NULL 사용 검색할 것
-------------------
-- NULL 과의 연산 결과 ---> 항상 NULL(연산 의미 없음)
SELECT * FROM DUAL; -- DUAL 테이블 일명 DUMMY 테이블(오라클 제공)
SELECT 100 + 200, 111 + 222 FROM DUAL;
SELECT 100 + NULL, 100 - NULL, 100 * NULL, 100 / NULL FROM DUAL;

SELECT * FROM TEST;
SELECT NUM, NUM + 100 FROM TEST;
SELECT NUM, NVL(NUM, 0), NVL(NUM, 0) + 100 FROM TEST;
----------------------
-- 정렬시 NULL
SELECT * FROM TEST ORDER BY STR2; --기본 오름차순 정렬, ASC 키워드 생략가능

--정렬시 오라클에서는 NULL 값을 가장 큰 값으로 처리(맨 마지막 출력)
--NULL  값 조회 순서 변경 :NULLS FIRST, NULLS LAST
SELECT * FROM TEST ORDER BY NUM; --오림차순
SELECT * FROM TEST ORDER BY NUM DESC; --내림차순
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; -- NULL값을 맨 앞으로
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST;-- NULL값을 맨 뒤로
-----------------------
INSERT INTO TEST (NUM, STR1, STR2)VALUES (200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; -- 데이터 조회 안됨

--=====================================
/* (실습) 테이블(TABLE) 만들기(테이블명: TEST2)
    NO : 숫자타입 5자리, PRIMARY KEY 선언
    ID : 문자타입 10자리(영문10자리), 값이 반드시 존재(NULL 허용안함)
    NAME : 한글 10자리 저장 가능하도록 설정, 값이 반드시 존재
    EMAIL : 영문, 숫자, 특수문자 포함 30자리
    ADDRESS : 한글 100자
    INNUM : 숫자타입 정수부 7자리, 소수부 3자리(1234567.123)
    REGDATE : 날짜타입
*********************/
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY,
    ID VARCHAR2 (10) NOT NULL,
    NAME VARCHAR2 (30) NOT NULL,
    EMAIL VARCHAR2 (30) ,
    ADDRESS VARCHAR2 (300) ,
    INNUM NUMBER (10,3),
    REGDATE DATE
);
SELECT * FROM TEST2;
INSERT INTO TEST2 
VALUES (23001, 'TEST1', '홍길동1', 'test@test.com', '서울시 강남구')
VALUES (23002, 'TEST2' , '홍길동2')
VALUES (23003, 'TEST3' , '홍길동3')
COMMIT;
-----------------
--(복사복제)특정 테이블의 테이블 구조와 데이터를 함께 복사
CREATE TABLE TEST3
AS
SELECT * FROM TEST2;

SELECT * FROM TEST3;
--======================
-- 특정 테이블의 특정 컬럼과 데이터만 복사하면서 테이블 생성


