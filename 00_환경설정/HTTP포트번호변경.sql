-- SQL 에서 한줄 주석 부호 (--)
-- http 포트 변경 : 8080 -> 8090
select DBMS_XDB.gethttpport() From dual;

--http 포트 8090 으로 변경 
exec dbms_xdb.sethttpport(8090);

select DBMS_XDB.gethttpport() From dual;

