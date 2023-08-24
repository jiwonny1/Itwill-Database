--PL/SQL 프로시저(PROCEDURE) - 오라클
SET SERVEROUTPUT ON; -- 서버쪽 화면을 볼 수 있게 설정

DECLARE --변수선언
    V_EMPID NUMBER(10);
    V_NAME VARCHAR2(30);
BEGIN --실행문 작성영역(시작)
    V_EMPID := 100; --치환문(대입문) 부호 (콜른이퀄 :=) 사용
    V_NAME := '홍길동';
    
    --화면출력
   DBMS_OUTPUT.PUT_LINE('HELLO PROCEDURE');
   DBMS_OUTPUT.PUT_LINE (V_EMPID || ' : ' || V_NAME);
    
END; --실행문 작성영역(끝)
---------------------
-- BOOK 테이블 데이터를 화면 출력
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    --SELECT ~ INTO ~ FROM 형태로 DB데이터 선택하고 INTO절 변수에 저장
    --1개의 데이터만 처리 가능
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = 4;
    
    DBMS_OUTPUT.put_line(V_BOOKID ||','|| V_BOOKNAME ||','|| 
            V_PUBLISHER ||','|| V_PRICE);
END;
--=============================
/* 저장 프로시저(stored procedure)
매개변수 (파라미터, PARAMETER) 유형
- IN :입력을 받기만 하는 변수 형태 (기본값)
-OUT : 출력만 하는 변수 형태
(값을 전달 받을수 없고, 프로시저 실행 후 저장된 값을 호출한 곳으로 전달 )
-IN OUT :  입력도 받고, 값을 변수를 통해 호출한 곳으로 전달(출력)
************************/
CREATE OR REPLACE PROCEDURE BOOK_DISP -- 프로시저 선언부
--매개변수 선언부 : ( ) 안에 작성, 타입만 지정, 여러개면 구분문자 콤마(,) 사용

(
    IN_BOOKID IN NUMBER
)
AS --변수 선언부 (AS 또는 IS~BEGIN 문 사이)
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
    DBMS_OUTPUT.put_line(V_BOOKID ||','|| V_BOOKNAME ||','|| 
            V_PUBLISHER ||','|| V_PRICE);
END;
----------
-- 프로시저 실행 : EXECUTE 프로시저명
EXECUTE BOOK_DISP(3);
EXEC BOOK_DISP(10);    --EXECUTE  줄여서 EXECU 사용가능


--프로시저 삭제 
DROP PROCEDURE BOOK_DISP;

--=========================
/* (실습)프로시저 작성하고 실행하기
고객테이블(CUSTOMER)에 있는 데이터 조회 프로시저 작성
- 프로시저명 : CUSTOMER_DISP
- 입력받는 값 : 고객ID
- 처리 : 입력받은 고객ID에 해당하는 데이터를 찾아서 화면 출력
- 출력항목 : 고객ID, 고객명, 주소, 전화번호
*********************************/
CREATE OR REPLACE PROCEDURE CUSTOMER_DISP
(
    IN_CUSTID IN NUMBER
)
AS 
    V_CUSTID CUSTOMER.CUSTID%TYPE;
    V_NAME CUSTOMER.NAME%TYPE;
    V_ADDRESS CUSTOMER.ADDRESS%TYPE;
    V_PHONE CUSTOMER.PHONE%TYPE;
BEGIN
    SELECT CUSTID, NAME, ADDRESS, PHONE
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER
    WHERE CUSTID = IN_CUSTID;
    
    DBMS_OUTPUT.put_line(V_CUSTID ||' , '|| V_NAME ||' , '|| 
            V_ADDRESS ||' , '|| V_PHONE);
END;

EXEC CUSTOMER_DISP(1);
    