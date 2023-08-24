/* ===================
SELECT * | [ DISTINCT ] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] 

--ASC : 오름차순(기본/생략가능)
--DESC : 내림차순
===================== */
--비교 : >, <, >= <=, =, <>,!=
--논리 : AND, OR, NOT
-- IN, NOT IN, 
--BETWEEN a AND b (a부터 b까지), NOT BETWEEN a AND b
--LIKE : %(퍼센트), _(언더바) -부분일치
-------------------------------------
SELECT * FROM BOOK;
SELECT * FROM customer;
SELECT * FROM orders;
--------------------
SELECT * FROM BOOK ORDER BY BOOKNAME; --오름차순
SELECT * FROM BOOK ORDER BY BOOKNAME DESC; --내림차순
SELECT * FROM BOOK ORDER BY BOOKNAME DESC; --내림차순
--출판사 기준 오름차순 (또는 내림차순), 책제목 오름차순(내림차순)
SELECT * FROM BOOK ORDER BY publisher, BOOKNAME;
--출판사 기준 오름차순, 가격이 큰것부터 (내림차순)
SELECT * FROM BOOK ORDER BY publisher, PRICE DESC;
----------------
--논리 : AND, OR, NOT
--출판사 대한미디어 , 금액이 3만원이상인 책 조회
SELECT * FROM BOOK 
WHERE publisher = '대한미디어' AND PRICE >=30000
;
--------------
--OR : 출판사 대한미디어 또는 이상미디어
SELECT *
FROM BOOK 
WHERE publisher = '대한미디어'OR publisher = '이상미디어'
;
--NOT : 출판사 굿스포츠를 제외하고 나머지 전체
SELECT *FROM BOOK 
WHERE publisher <> '굿스포츠'; --<> 같지않다 부호 !=와 동일 
-----------------------
--(실습) 출판사가 굿스포츠 , 대한미디어 출판사가 아닌 도서 목록
SELECT *FROM BOOK 
WHERE publisher <> '굿스포츠' AND  publisher != '대한미디어'
;
--in :안에 있나? (OR문 단순화)
-- 나무수 , 대한미디어, 삼성당에서 출판한 도서목록
SELECT *FROM BOOK 
WHERE publisher = '나무수' OR publisher = '대한미디어'
OR publisher = '삼성당'
;
SELECT *FROM BOOK 
WHERE publisher IN ('나무수' , '대한미디어', '삼성당')
;
-- 나무수 , 대한미디어, 삼성당에서 출판한 도서가 아닌 목록
SELECT *FROM BOOK 
WHERE publisher <> '나무수' AND  publisher <> '대한미디어'
AND publisher <> '삼성당'
;
SELECT *FROM BOOK 
WHERE publisher NOT IN ('나무수' , '대한미디어', '삼성당')
;
--NOT IN 이 더 직관적 
--=============================
--같다 (=), 크다 (>), 작다(<), 크거나 같다(>=), 작거나 같다(<=)
--같지않다 (다르다) : <>, !=
-- 출판된 책중에 8000원 이상이고, 22000원 이하인 책 (가격순 정렬)
--BETWEEN 값1 AND 값2 :값1부터 값2까지
SELECT * FROM BOOK 
WHERE price >= 8000 AND price <= 22000 
ORDER BY PRICE;

SELECT * FROM BOOK 
WHERE price  BETWEEN 8000 AND 22000 
ORDER BY PRICE;

--출판된 책중에 8000원 보다 작거나, 22000원 보다 큰 책(가격순 정렬)
SELECT * FROM BOOK 
WHERE price < 8000 OR price > 22000 
ORDER BY PRICE;

SELECT * FROM BOOK 
WHERE price NOT BETWEEN 8000 AND 22000 
ORDER BY PRICE;
--===================================
--책 제목이 '야구' ~ '올림픽' (책제목 오름차순 정렬)
SELECT * FROM BOOK
WHERE BOOKNAME >= '야구' AND BOOKNAME <= '올림픽'
ORDER BY BOOKNAME;

SELECT * FROM BOOK
WHERE BOOKNAME BETWEEN '야구' AND '올림픽'
ORDER BY BOOKNAME;
-----------------
--실습(BETWEEN)출판사 나무수~ 삼성당 출판사 책 (출판사명 오름차순 정렬)
SELECT * FROM BOOK
WHERE publisher BETWEEN '나무수' AND '삼성당'
ORDER BY publisher;

--실습(IN) 대한미디어, 이상미디어, 출판한 책목록 (출판사 명, 책제목 정렬)
SELECT * FROM BOOK
WHERE publisher IN ('대한미디어', '이상미디어')
ORDER BY publisher,BOOKNAME;

--===============================
--LIKE :%,_ 부호와 함께 사용
--% : 전체(모든것)를 의미(0,1,N)
--_(언더바) : 문자1개에 대하여 모든것을 의미 (1개의 문자 반드시 있어야함)
-------------------------------
SELECT * FROM BOOK
WHERE publisher LIKE '%미디어'
;
--야구로 시작하는 책 조회
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '야구%'
;
--
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '%단계%' -- 책 제목에 단계라는 단어가 있는지 여부를 조회 
;
--(실습) 책 제목에 '구' 문자가 있는 책 목록
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '%구%'
;
--(실습) 책 제목 중 2,3 번째 글자가 <구의>인 책 목록(언더바 사용)
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '_구의%'
;
--(실습) 책 제목에  '를' 문자가 3번째 위치한 책 목록(언더바 사용)
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '__를%'
;
