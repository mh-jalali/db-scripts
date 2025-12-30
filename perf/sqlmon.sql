--------------------------------------------------------------------------------
--
-- Script : sqlmon.sql v1.1
--
-- Description : SQL monitoring
-- Author : Mohamad Hosein Jalali <jalalii.mh@gmail.com>
--
--
-- Usage :
--    @sqlmon <sql_id> <sql_exec_id> <type>
--    
--    type - HTML/ACTIVE/XML/TEXT
--
--------------------------------------------------------------------------------
SET lines 200
SET pages 1000
SET long 999999
SET longchunksize 200

SELECT
   DBMS_SQLTUNE.REPORT_SQL_MONITOR (
      sql_id   => &1,
      sql_exec_id => &2,
      type     => &3
   ) AS report
FROM DUAL
/