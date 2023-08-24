/* 비교구문(분기처리) IF 문
IF (조건식) THEN ~ END IF;
IF (조건식) THEN ~ ELSE ~ END IF;
IF (조건식) THEN ~ ELSIF ~ ELSIF ~ ELSE ~ END IF;
*******************/
-- 홀수, 짝수 판별
create or replace PROCEDURE PRC_IF (
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>입력값 : ' || IN_NUM);
    DBMS_OUTPUT.PUT_LINE('2로 나눈 나머지 : ' || MOD(IN_NUM, 2)); 
    
    -- 홀, 짝 판별
    IF (MOD(IN_NUM, 2) = 0) THEN
        DBMS_OUTPUT.PUT_LINE(IN_NUM || ' : 짝수');
    ELSE 
        DBMS_OUTPUT.PUT_LINE(IN_NUM || ' : 홀수');
    END IF;
END;
-------------------
-- 4로 나눈 나머지 값 확인
create or replace PROCEDURE PRC_IF2 (
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>입력값 : ' || IN_NUM);
    --DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 : ' || MOD(IN_NUM, 4)); 
    
    --4로 나눈 나머지 값 확인
    IF (MOD(IN_NUM, 4) = 0) THEN
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 0');
    ELSIF (MOD(IN_NUM, 4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 1');
    ELSIF (MOD(IN_NUM, 4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 3');
    END IF;
END;

--=====================
-- 반복문 : FOR, WHILE
-- FOR 변수 IN 시작값 .. 최종값 LOOP ~ END LOOP
-----------------
-- 숫자(N) 하나를 입력받아서 합계 출력(1~N 까지의 합)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0; --합계 저장할 변수 선언(초기값 0 설정)
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>입력값 : ' || IN_NUM);
    
    --입력받은 숫자까지의 합계 구하기
    -- FOR 변수 IN 시작값 .. 최종값 LOOP ~ END LOOP
    FOR I IN 1 .. IN_NUM LOOP
        V_SUM := V_SUM + I;
        DBMS_OUTPUT.PUT_LINE('>> I : ' || I);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('::: 1부터 '|| IN_NUM || '까지의 합계 : '|| V_SUM);
END;
----------------
-- FOR문 REVERSE 옵션 사용(최종값에서 시작값으로 반복인자 변경)
CREATE OR REPLACE PROCEDURE PRC_FOR_REVERSE (
    IN_NUM IN NUMBER
) AS
BEGIN
    FOR I IN REVERSE 1 .. IN_NUM LOOP
        DBMS_OUTPUT.PUT_LINE('>> I : ' || I);
    END LOOP;
END;

--===========================
-- WHILE 문
-- WHILE (조건식) LOOP ~ END LOOP;
------------
-- 숫자(N) 하나를 입력받아서 합계 출력(1~N 까지의 합)
create or replace PROCEDURE PRC_FOR_SUM (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0; --합계 저장할 변수 선언(초기값 0 설정)
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>입력값 : ' || IN_NUM);
    
    --입력받은 숫자까지의 합계 구하기
    -- FOR 변수 IN 시작값 .. 최종값 LOOP ~ END LOOP
    FOR I IN 1 .. IN_NUM LOOP
        V_SUM := V_SUM + I;
        DBMS_OUTPUT.PUT_LINE('>> I : ' || I);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('::: 1부터 '|| IN_NUM || '까지의 합계 : '|| V_SUM);
END;

--====================
/* LOOP ~ END LOOP; --무한반복
LOOP
    EXIT WHEN (조건식);
END LOOP;
***************/
create or replace PROCEDURE LOOP1
AS
    I NUMBER(3) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        
        EXIT WHEN (I >= 10);
        I := I + 1;
    END LOOP;
END LOOP1;

--==============================
/*(실습) 숫자를 하나 입력 받아서 1 ~ 숫자까지의 합계 구하기
프로시저명 : PRC_SUM_EVENODD
-- 입력값이 홀수면 홀수값만 더하고
-- 입력값이 짝수면 짝수값만 더해서
최종 합계값을 화면에 출력
<출력형태>
-- 입력숫자: 입력값, 홀수/짝수, 합계 : 합계결과
   출력예) 입력숫자 : 4, 짝수, 합계 : 6
   출력예) 입력숫자 : 5, 홀수, 합계 : 9
*********************/
CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD(
     IN_NUM IN NUMBER
 ) AS 
    V_SUM NUMBER := 0;
BEGIN 
      IF (MOD(IN_NUM, 2) = 0) THEN
        FOR I IN REVERSE 1 .. IN_NUM LOOP
          IF(MOD(I,2)=0) THEN
           V_SUM := V_SUM + I;
           DBMS_OUTPUT.PUT_LINE('I : '|| I);
           END IF;
           END LOOP;
        ELSE  
        FOR I IN REVERSE 1 .. IN_NUM LOOP
          IF(MOD(I,2)=1) THEN
           V_SUM := V_SUM + I;
           DBMS_OUTPUT.PUT_LINE('I : '|| I);
           END IF;
            END LOOP;
    END IF;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || V_SUM);
END PRC_SUM_EVENODD;



