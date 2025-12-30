--------------------------------------------------------------------------------
--
-- Script : drop_sql_patch.sql
--
-- Version : 1.0
--
-- Description : Drop SQL Patch
--
-- Author : Mohamad Hosein Jalali <jalalii.mh@gmail.com>
--
-- Usage :
--    @drop_sql_patch <sql_patch_name>
--
-- Example :
--    @drop_sql_patch SQL_PATCH_a56yhrgz2paca
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET FEED OFF
SET VERIFY OFF
SET ECHO OFF

DECLARE
   l_sql_patch_name VARCHAR2(50 Char);
BEGIN
   DBMS_OUTPUT.PUT_LINE(q'[Searching for SQL Patch &1 ...]');

   SELECT
      name
   INTO
      l_sql_patch_name
   FROM
      dba_sql_patches
   WHERE
      name = '&1';

   DBMS_SQLDIAG.DROP_SQL_PATCH (
      name => '&1'
   );

   DBMS_OUTPUT.PUT_LINE(q'[SQL Patch &1 dropped.]');


EXCEPTION
   -- Raise if sql_id not found.
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE(q'[SQL Patch &1 not found.]');

   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(
            'Error: '
            || SQLERRM
            || ' - Backtrace: '
            || SYS.DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
         );
END;
/

SET SERVEROUTPUT OFF