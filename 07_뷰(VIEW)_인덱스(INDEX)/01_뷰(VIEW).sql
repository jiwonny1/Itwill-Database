/* ************************
뷰(VIEW) : 하나 또는 둘 이상의 테이블로 부터
   데이터의 부분집합을 테이블인 것처럼 사용하는 객체(가상테이블)
--뷰(VIEW) 생성문
CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ..., 컬럼별칭n)]
AS
SELECT 문장
[옵션];

--읽기전용 옵션 : WITH READ ONLY

--뷰(VIEW) 삭제
DROP VIEW 뷰이름;
***************************/

SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
-- 뷰(VIEW) 만들기
CREATE OR REPLACE VIEW VW_BOOK
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;
-- 뷰 사용해서 데이터 검색
SELECT * FROM VW_BOOK;
SELECT * FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%');

SELECT * FROM VW_BOOK
WHERE PUBLISHER = '굿스포츠';
---------------------
CREATE OR REPLACE VIEW VW_BOOK2
    (BID, BNAME, PUB, PRICE) -- 컬럼 별칭 사용
AS
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM BOOK
WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;
----------
-- 뷰 삭제
DROP VIEW VW_BOOK; --뷰 삭제
----------------------------
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.*,
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.ADDRESS, C.PHONE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
WITH READ ONLY
;
SELECT * FROM VW_ORDERS WHERE NAME = '박지성';
SELECT * FROM VW_ORDERS WHERE PUBLISHER = '굿스포츠';
--=========================




--(실습) 뷰를 생성, 조회, 삭제
--1. 뷰생성 - 뷰명칭 : VW_ORD_ALL
---- 주문(판매)정보, 책정보, 고객정보 모두 조회할 수 있는 형태 뷰 
--2. 이상미디어에서 출판한 책중 판매된 책제목, 판매금액, 판매일 조회
--3. 이상미디어에서 출판한 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가(정가), 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근순
--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
--1
CREATE VIEW VW_ORD_ALL
AS
SELECT O.*,
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.ADDRESS, C.PHONE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
with read only
;
--2
SELECT BOOKNAME, SALEPRICE, ORDERDATE FROM VW_ORD_ALL WHERE PUBLISHER = '이상미디어';
--3
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
FROM VW_ORD_ALL
WHERE NAME IN ('추신수', '장미란')
ORDER BY NAME, ORDERDATE DESC
;
--4
SELECT COUNT(*), SUM(PRICE),TRUNC(AVG(PRICE)), MAX(PRICE), MIN(PRICE)
FROM VW_ORD_ALL
GROUP BY CUSTID
;
--(뷰 삭제)
DROP VIEW VW_ORD_ALL;





