/* 시퀀스(SEQUENCE) ******
SEQUENCE : DB에서 제공하는 자동채번 객체
생성 : CREATE SEQUENCE 시퀀스명;
삭제 : DROP SEQUENCE 시퀀스명; 

시퀀스명.NEXTVAL : 시퀀스 번호(값) 생성
시퀀스명.CURRVAL : 현재 시퀀스값 확인(NEXTVAL 한 번 이상 실행 후)
****************/
CREATE SEQUENCE "MADANG"."SEQUENCE1"
MINVALUE 1 MAXVALUE	9999999999999999999999999999
INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
------------------------------
SELECT SEQUENCE1.NEXTVAL FROM DUAL;
SELECT SEQUENCE1.CURRVAL FROM DUAL;
-------------------------------------
--BOOK 테이블에 INSERT 작업, BOOKID 최대값 + 1
INSERT INTO BOOK
        (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES ((SELECT NVL(MAX(BOOKID),0) + 1 FROM BOOK), 
        'MAX(BOOKID)+1 값', 'TEST', 20000);
        
SELECT * FROM BOOK ORDER BY BOOKID DESC;
------------------------------------------------
-- 시퀀스 사용(시작번호 50, NOCACHE)
CREATE SEQUENCE SEQ_BOOK  
--INCREMENT BY 1              --증분의 디폴트 값은 1이므로 생략가능
START WITH 50 
NOCACHE;
---------------------
--SELECT SEQ_BOOK.NEXTVAL FROM DUAL;
-- BOOK 테이블에 시퀀스 사용해서 입력처리
-- 시퀀스는 여러 테이블에서 사용가능하다.
INSERT INTO BOOK
        (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (SEQ_BOOK.NEXTVAL, 'SEQ_BOOK.NEXTVAL 사용', 'TEST', 20000);
SELECT * FROM BOOK ORDER BY BOOKID DESC;
--=======================================
