/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
--5) 이름(first_name)이 john인 사원의 모든 정보 조회
--6) 이름(first_name)이 john인 사원은 몇 명인가?
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
---------------------------------
--11) 직종별 최대 월급여 검색
--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
--13) 직종별 평균급여 이상인 직원 조회
*****************************/
--1
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100
;
--2
SELECT *
FROM EMPLOYEES
WHERE SALARY >15000
;
--3
SELECT EMPLOYEE_ID AS 사번, LAST_NAME AS 이름, HIRE_DATE AS 입사일, SALARY AS 월급여
FROM EMPLOYEES
WHERE SALARY >15000
;
--4
SELECT EMPLOYEE_ID AS 사번, LAST_NAME AS 이름, HIRE_DATE AS 입사일, SALARY AS 월급여
FROM EMPLOYEES
WHERE SALARY < 10000
ORDER BY SALARY
;
--5
SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) ='john'
;
--5) 이름(first_name)이 john인 사원의 모든 정보 조회 (답안)
---- john, JOHN, John, ....
SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john') --데이터가 표준화 된 경우 입력값을 동일한 형태로
;
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME)
FROM EMPLOYEES
;
--6
SELECT COUNT(*)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) ='john'
;
--7
SELECT EMPLOYEE_ID AS 사번, CONCAT(FIRST_NAME,' '||LAST_NAME) AS 성명, SALARY AS 월급여, HIRE_DATE AS 입사일
FROM EMPLOYEES
WHERE SUBSTR (TO_CHAR(HIRE_DATE) , 1, 4) = '2008'
;
--8
SELECT EMPLOYEE_ID AS 사번, CONCAT(FIRST_NAME,' '||LAST_NAME) AS 성명, SALARY AS 월급여
FROM EMPLOYEES
WHERE SALARY >= 20000 AND SALARY <=30000
;
--9
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL
;
--10
SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
;
--11
SELECT JOB_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY MAX(SALARY)
;
--12
SELECT JOB_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING  MAX(SALARY)>10000
ORDER BY MAX(SALARY)
;
--13
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY MAX(SALARY)
;

SELECT E.JOB_ID, E.LAST_NAME, E.SALARY ,S.AVG_SALARY
FROM EMPLOYEES E,
        (SELECT JOB_ID, AVG(SALARY) AS AVG_SALARY
        FROM EMPLOYEES
        GROUP BY JOB_ID
        ) S
WHERE E.JOB_ID = S.JOB_ID
AND E.SALARY >= S.AVG_SALARY
ORDER BY E.JOB_ID, E.SALARY
;
---------------
--서브쿼리 방식으로 찾기
SELECT*
FROM EMPLOYEES
WHERE SALARY >= (회사평균급여)
;
SELECT AVG(SLAARY) FROM EMPLOYEES; -- 회사평균 급여
--->
-- 상관서브쿼리 방식으로 찾기
SELECT *
FROM EMPLOYEES E
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES 
                 WHERE JOB_ID = E.JOB_ID)
;



