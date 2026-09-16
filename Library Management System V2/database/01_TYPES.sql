--------------------------------------------------------
--  DDL for Type LIBRARIAN_OBJ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "LIBRARIAN_OBJ" AS OBJECT (
    id         NUMBER(10, 0),
    username   VARCHAR2(50 CHAR),
    first_name VARCHAR2(100 CHAR),
    last_name  VARCHAR2(100 CHAR),
    email      VARCHAR2(254 CHAR),
    is_active  CHAR(1 CHAR)
);

/
--------------------------------------------------------
--  DDL for Type LIBRARIAN_TABLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "LIBRARIAN_TABLE" AS
    TABLE OF librarian_obj;

/
--------------------------------------------------------
--  DDL for Type LOGIN_RESULT_OBJ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "LOGIN_RESULT_OBJ" AS OBJECT (
    id         NUMBER(10, 0),
    username   VARCHAR2(50 CHAR),
    first_name VARCHAR2(100 CHAR),
    last_name  VARCHAR2(100 CHAR),
    email      VARCHAR2(254 CHAR),
    message    VARCHAR2(200)
);

/
