/* DECODE, CASE WHEN : SQL문 내에서 IF문 구현(CASE : 표준SQL)
DECODE : 동등비교만 가능(동일 데이터 확인)
DECODE(대상, 비교값, 같을때 처리문, 다를때 처리문);
DECODE(대상, 비교값, DECODE(), DECODE());
DECODE(대상, 비교값1, 처리문1
          , 비교값2, 처리문2
          , ...
          , 비교값n, 처리문n
          , 처리문n+1)
**************************************/














--===============================================
/* **** CASE WHEN 문 ************
형태1 : DECODE문 처럼 동등비교
CASE 기준값
     WHEN 비교값1 THEN 일치하면 처리할 구문
     WHEN 비교값2 THEN 일치하면 처리할 구문
     ...
     WHEN 비교값n THEN 일치하면 처리할 구문
     ELSE 위에 일치하는 경우가 없으면 실행할 구문
END
--------
형태2 : IF THEN ELSE 처럼 사용(부등비교 처리 가능)
--CASE문 내의 처리문장에는 CASE중복 사용 가능
--비교구문 : =, <>, !=, >, <, >=, <=, AND, OR, NOT 사용가능
CASE WHEN 비교구문
     THEN 비교구문 결과 TRUE인 경우 처리구문
     ELSE 비교구문 결과 FALSE인 경우 처리구문
END   
------
CASE WHEN 비교구문(예: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   
-----
CASE WHEN 비교구문 THEN 처리구문
     WHEN 비교구문 THEN 처리구문
     ....
     ELSE 위의 비교구문에 해당되지 않는 경우 처리구문
END 
****************************************/