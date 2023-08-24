--서브(SUB QUERY) : SQL문 내부에 있는 SQL문
--SQL(SELECT, INSERT, UPDATE, DELETE)문 내에 있는 쿼리문
--속도가 느려지는 문제가 있기때문에 JOIN으로 쓸수있으면 쓰고 
--서브쿼리를 쓸 수 밖에 없는 상황에만 사용한다.
-----------------------
SELECT O.ORDERID, O.SALEPRICE, O.ORDERDATE,
       O.CUSTID, C.NAME,
       O.BOOKID,
       (SELECT BOOKNAME FROM BOOK 
        WHERE BOOKID = O.BOOKID) AS BOOK_NAME --스칼라 서브쿼리(Scalar Subquery)
FROM ORDERS O,
     (SELECT * FROM CUSTOMER WHERE NAME IN ('장미란', '추신수')) C --인라인 뷰(Inline View)
WHERE O.CUSTID = C.CUSTID
  AND SALEPRICE > (SELECT AVG(SALEPRICE) FROM ORDERS) --중첩 서브쿼리(Nested Subquery)
;
--=========================
-- 박지성이 구입한 내역을 검색
SELECT * FROM ORDERS; --구입내역
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; -- CUSTID : 1
SELECT * FROM ORDERS
WHERE CUSTID = 1
;
--서브쿼리 사용
SELECT * FROM ORDERS
WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성')
;
--조인문 처리
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C --조인테이블
 WHERE O.CUSTID = C.CUSTID --조인조건
   AND C.NAME = '박지성' --선택조건
;
----------------
-- WHERE 절에서 서브쿼리 사용시 서브쿼리 조회 결과가 2건 이상인 경우 IN 사용
SELECT * FROM ORDERS
WHERE CUSTID IN (SELECT CUSTID FROM CUSTOMER 
                 WHERE NAME IN ('박지성', '김연아'))
;
-------------
--(서브쿼리) 책중 정가가 가장 비싼 도서의 이름을 구하시오
SELECT MAX(PRICE) FROM BOOK; --35000 : 가장 비싼 책 금액
SELECT * FROM BOOK WHERE PRICE = 35000;
-- 서브쿼리를 WHERE 절에 사용
SELECT * FROM BOOK 
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
-----------------
-- 서브쿼리를 FROM 절에 사용(테이블 조인)
SELECT *
  FROM BOOK B,
       (SELECT MAX(PRICE) AS MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE -- 찾을조건
;
-------
--(실습)김연아, 박지성 구입내역(서브쿼리 - FROM절)
-- 단순 테이블 조인 했을때
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C 
 WHERE O.CUSTID = C.CUSTID 
   AND (C.NAME = '박지성' OR C.NAME = '김연아')
   -- AND NAME IN ('박지성', '김연아')
;
--먼저 김연아, 박지성 정보 조회
SELECT *
FROM CUSTOMER WHERE NAME IN ('김연아', '박지성');
--서브 쿼리를 FROM 절에 사용
SELECT *
FROM ORDERS O,
        (SELECT * FROM CUSTOMER WHERE NAME IN ('김연아', '박지성')) C
WHERE O.CUSTID = C.CUSTID
;
-------------------
-- SELECT 절에 서브쿼리 사용
SELECT * FROM ORDERS;
SELECT ORDERID, CUSTID, BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = ORDERS.CUSTID) CUST_NAME,
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = ORDERS.BOOKID) BOOK_NAME,
       SALEPRICE, ORDERDATE
  FROM ORDERS
;
-----------
-- 박지성이 구매한 책 목록
SELECT *
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID
                                      FROM CUSTOMER
                                     WHERE NAME IN ('박지성'))
                 )
;
--=================================
--(실습) 서브쿼리 이용
--1. 한 번이라도 구매한 내역이 있는 사람
---- (또는 한 번도 구매하지 않은 사람)
--2. 20000원 이상되는 책을 구입한 고객 명단 조회
--3. '대한미디어' 출판사의 책을 구매한 고객이름 조회
--4. 전체 책가격 평균보다 비싼 책의 목록 조회
------------------------
--1
SELECT COUNT(*)
FROM ORDERS
GROUP BY CUSTID
;
SELECT C.NAME, O.*
FROM CUSTOMER C, (SELECT CUSTID, COUNT(*) FROM ORDERS
                    GROUP BY CUSTID) O
WHERE c.custid = O.CUSTID
;
--(답안)
-- 1. 한 번도 구매하지 않은 사람
SELECT *
FROM CUSTOMER 
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--2
SELECT *
FROM ORDERS
WHERE SALEPRICE >= 20000
;
SELECT C.NAME, O.CUSTID, O.SALEPRICE 
FROM CUSTOMER C,(SELECT BOOKID, SALEPRICE, CUSTID
          FROM ORDERS
            WHERE SALEPRICE >=20000) O
WHERE C.CUSTID = O.CUSTID
;
--(답안)
--2. 20000원 이상되는 책을 구입한 고객 명단 조회
SELECT * FROM ORDERS WHERE SALEPRICE >= 20000;
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000)
;

--3
SELECT NAME
FROM CUSTOMER C, (SELECT *
FROM BOOK 
WHERE PUBLISHER = '대한미디어')
WHERE  
;
--(답안)
--3. '대한미디어' 출판사의 책을 구매한 고객이름 조회
SELECT * FROM BOOK WHERE PUBLISHER = '대한미디어';
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID FROM BOOK
                                     WHERE PUBLISHER = '대한미디어')
                 )
;

--(답안)
--4. 전체 책가격 평균보다 비싼 책의 목록 조회
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT *
  FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK)
;  
