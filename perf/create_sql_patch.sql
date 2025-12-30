--------------------------------------------------------------------------------
--
-- Script : create_sql_patch.sql
--
-- Version : 1.0
--
-- Description : Create SQL Patch
--
-- Author : Mohamad Hosein Jalali <jalalii.mh@gmail.com>
--
-- Usage :
--    @create_sql_patch <sql_id> <hints> <sql_patch_name>
--
-- Example :
--    @create_sql_patch a56yhrgz2paca FULL(@"SEL$1" "T"@"SEL$1") SQL_PATCH_a56yhrgz2paca
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET FEED OFF
SET VERIFY OFF
SET ECHO OFF

DECLARE
   l_sql_text CLOB;
   l_ret VARCHAR2(50 Char);
   l_sql_patch_name VARCHAR2(50 Char);
BEGIN
   DBMS_OUTPUT.PUT_LINE(q'[Searching for SQL_ID : &1]');

   -- Search for given sql_id.
   SELECT
      sql_fulltext
   INTO l_sql_text
   FROM
      gv$sqlstats
   WHERE 
      sql_id = '&1'
      AND rownum = 1;
   
   DBMS_OUTPUT.PUT_LINE(q'[Found SQL : ]' || SUBSTR(l_sql_text,1,80) || '...');

   -- TODO: Use PL/SQL conditional compilation
   -- TODO: Check for invalid hints
   -- TODO: Check if we can create sql patch for force matching signature

   l_sql_patch_name := NVL('&3','SQL_PATCH_&1');

   l_ret := DBMS_SQLDIAG.CREATE_SQL_PATCH (
      sql_id      => '&1',
      hint_text   => q'[ &2]',
      name        => l_sql_patch_name
   );

   IF (l_ret != l_sql_patch_name) THEN
      NULL;
   END IF;


   DBMS_OUTPUT.PUT_LINE(q'[SQL Patch ]' || l_sql_patch_name || ' Created.');

EXCEPTION
   -- Raise if sql_id not found.
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE(q'[SQL with SQL_ID &1 not found.]');

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
