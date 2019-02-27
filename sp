CREATE OR REPLACE PROCEDURE DROPIFEXISTS(TBL IN VARCHAR2)
IS
rv NUMBER(3);
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE '||TBL;
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/
----------------------------------------------------------------


CREATE OR REPLACE FUNCTION PMT(RATE NUMBER,NPER NUMBER,PRESENT_VALUE NUMBER)
return NUMBER
is
PAYMENT NUMBER;
begin

/*
rate x loan amount x (1+rate)^number payments
------------------------------------------------
        (1+rate)^number payments - 1
*/

PAYMENT:= CASE WHEN RATE=0 THEN PRESENT_VALUE/NPER 
               ELSE ((RATE*PRESENT_VALUE*POWER((1+RATE),NPER))/(POWER((1+RATE),NPER)-1)) END;
return PAYMENT;
end;
/

----------------------------------------------------------------


CREATE OR REPLACE FUNCTION ISNUMERIC (PARAM IN CHAR) RETURN NUMBER AS
    DUMMY VARCHAR2(100);
BEGIN
    DUMMY:=TO_CHAR(TO_NUMBER(PARAM));
    RETURN (1);
EXCEPTION
    WHEN OTHERS THEN
        RETURN (0);
END;
/
----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE  SP_CREATE IS
stmt varchar2(1500);
  BEGIN
  stmt:='create table TABLE_DYN as 
        select  * from DUAL';
EXECUTE IMMEDIATE stmt;
end  SP_CREATE;
/


----------------------------------------------------------------


CREATE OR REPLACE FUNCTION  form_url_encode (
   data    IN VARCHAR2,
   charset IN VARCHAR2) RETURN VARCHAR2 AS 
BEGIN 
  RETURN utl_url.escape(data, TRUE, charset); -- note use of TRUE
END;
/


CREATE OR REPLACE FUNCTION form_url_decode(
   data    IN VARCHAR2, 
   charset IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN 
  RETURN utl_url.unescape(
     replace(data, '+', ' '), 
     charset); 
     EXCEPTION
   WHEN OTHERS THEN
    RETURN 'DECODE HATA';
END;
/

CREATE OR REPLACE function  ISDATE(p_val in varchar2)
return number
is
  not_a_valid_day   exception;
  not_a_valid_month exception;
  pragma exception_init(not_a_valid_day, -1847);
  pragma exception_init(not_a_valid_month, -1843);
  l_date date;
begin
  l_date := to_date(p_val, 'ddmm');
  return 1;
exception
  when not_a_valid_day or not_a_valid_month
  then return 0;
end;
/

CREATE OR REPLACE FUNCTION  PARSE (TEXT in varchar2, SIRA in number) RETURN VARCHAR2 AS
    DUMMY VARCHAR2(100);
BEGIN
 RETURN    PARSE from ( select regexp_substr('a|b|c','[^|]+', 1, level) PARSE from dual where  level = 2   connect by regexp_substr('a|b|c', '[^|]+', 1, level) is not   null)z;
 
  end
/

