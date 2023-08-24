/**********************************
<숫자 관련 내장함수>
숫자함수 : SQL에서는 사칙연산(+, -, *, /)과 나머지 연산(MOD) 사용
ABS(숫자) : 절대값
FLOOR(숫자) : 소수점 아래 버림
CEIL(숫자) : 올림 
ROUND(숫자) : 반올림 - 소수점 이하 반올림
ROUND(숫자, 자리수) : 자리수 이하 반올림 예) ROUND(95.789, 2) -> 95.79
TRUNC(숫자) : 정수만 남기고, 소수부 버림
TRUNC(숫자, 자리수) : 정수 이하 자리수까지 유지 
MOD(숫자, 나누는수) : 나머지
SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
POWER(숫자, n) : 숫자의 n제곱 값 계산(POWER(2, 3) -> 8) 
***********************************/
--숫자연산 : SQL에서는 사칙연산(+, -, *, /)과 나머지 연산(MOD) 사용
SELECT 10+3, 10-3, 10*3, 10/3, MOD(10,3) FROM DUAL;

--ABS(숫자) : 절대값
SELECT ABS(-30.45), ABS(30.45) FROM DUAL;

--FLOOR(숫자) : 작은 숫자(아래쪽 숫자)를 선택한다
SELECT FLOOR(30.999), FLOOR(30.111) FROM DUAL; -- 30, 30
SELECT FLOOR(-30.999), FLOOR(-30.111) FROM DUAL; -- -31, -31

--CEIL(숫자) : 올림, 큰숫자를 선택
SELECT CEIL(30.999), CEIL(30.111) FROM DUAL; -- 31, 31
SELECT CEIL(-30.999), CEIL(-30.111) FROM DUAL; -- -30, -30

--ROUND(숫자) : 반올림 - 소수점 이하 반올림
--ROUND(숫자, 자리수) : 자리수 이하 반올림 예) ROUND(95.789, 2) -> 95.79
SELECT ROUND(30.5), ROUND(30.4) FROM DUAL; --31, 30
SELECT ROUND(30.45), ROUND(30.44) FROM DUAL; --30, 30
SELECT ROUND(30.45, 1), ROUND(30.44, 1) FROM DUAL; --30.5	30.4
SELECT ROUND(30.445, 2), ROUND(30.444, 2) FROM DUAL; --30.45	30.44

--TRUNC(숫자) : 정수만 남기고, 소수부 버림
--TRUNC(숫자, 자리수) : 정수 이하 자리수까지 유지 
SELECT TRUNC(30.999), TRUNC(30.111) FROM DUAL; -- 30, 30
SELECT TRUNC(-30.999), TRUNC(-30.111) FROM DUAL; -- -31, -31

SELECT TRUNC(1234.123, 1), TRUNC(1234.123, 2) FROM DUAL; --1234.1	1234.12

--MOD(숫자, 나누는수) : 나머지
SELECT MOD(1000, 3), MOD(999, 5) FROM DUAL;

--SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
SELECT SIGN(0), SIGN(55), SIGN(-55) FROM DUAL; --0  1  -1

--POWER(숫자, n) : 숫자의 n제곱 값 계산(POWER(2, 3) -> 8) 
SELECT POWER(2,3), POWER(2,4), POWER(2,16), POWER(2,32) FROM DUAL;
SELECT POWER(8,3), POWER(8,4), POWER(8,16), POWER(8,32) FROM DUAL;











