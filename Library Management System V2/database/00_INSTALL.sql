-- ============================================================
-- Library Database - Installation Script
-- ============================================================

SET DEFINE OFF;
SET SERVEROUTPUT ON;

PROMPT
PROMPT ========================================================
PROMPT LIBRARY DATABASE INSTALLATION
PROMPT ========================================================
PROMPT

PROMPT [1/11] Creating TYPES...
@@01_TYPES.sql

PROMPT [2/11] Creating TABLES...
@@02_TABLES.sql

PROMPT [3/11] Creating VIEWS...
@@03_VIEWS.sql

PROMPT [4/11] Creating INDEXES...
@@04_INDEXES.sql

PROMPT [5/11] Creating TRIGGERS...
@@05_TRIGGERS.sql

PROMPT [6/11] Creating PROCEDURES...
@@06_PROCEDURES.sql

PROMPT [7/11] Creating FUNCTIONS...
@@07_FUNCTIONS.sql

PROMPT [8/11] Creating PACKAGES...
@@08_PACKAGES.sql

PROMPT [9/11] Creating PACKAGE BODIES...
@@09_PACKAGE_BODIES.sql

PROMPT [10/11] Creating CONSTRAINTS...
@@10_CONSTRAINTS.sql

PROMPT [11/11] Creating FOREIGN KEY CONSTRAINTS...
@@11_REF_CONSTRAINTS.sql

PROMPT
PROMPT ========================================================
PROMPT LIBRARY DATABASE INSTALLATION COMPLETE
PROMPT ========================================================
PROMPT