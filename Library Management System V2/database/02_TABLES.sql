--------------------------------------------------------
--  DDL for Table AUTHOR
--------------------------------------------------------

  CREATE TABLE "AUTHOR" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"FIRST_NAME" VARCHAR2(100 CHAR), 
	"LAST_NAME" VARCHAR2(100 CHAR), 
	"BIRTH_YEAR" NUMBER(4,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BOOK
--------------------------------------------------------

  CREATE TABLE "BOOK" 
   (	"ISBN" VARCHAR2(13 CHAR), 
	"TITLE" VARCHAR2(250 CHAR), 
	"SUBTITLE" VARCHAR2(250 CHAR), 
	"PUBLICATION_YEAR" NUMBER(4,0), 
	"EDITION" VARCHAR2(100 CHAR), 
	"BOOK_LANGUAGE" VARCHAR2(50 CHAR), 
	"PAGE_COUNT" NUMBER(5,0), 
	"SUMMARY" VARCHAR2(1000 CHAR), 
	"COVER_IMAGE_PATH" VARCHAR2(500 CHAR), 
	"IS_ACTIVE" CHAR(1 CHAR), 
	"PUBLISHER_ID" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BOOK_AUTHOR
--------------------------------------------------------

  CREATE TABLE "BOOK_AUTHOR" 
   (	"ISBN" VARCHAR2(13 CHAR), 
	"AUTHOR_ID" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BOOK_CATEGORY
--------------------------------------------------------

  CREATE TABLE "BOOK_CATEGORY" 
   (	"ISBN" VARCHAR2(13 CHAR), 
	"CATEGORY_ID" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BOOK_COPY
--------------------------------------------------------

  CREATE TABLE "BOOK_COPY" 
   (	"BARCODE" NUMBER(13,0), 
	"ISBN" VARCHAR2(13 CHAR), 
	"SHELF_ID" NUMBER(10,0), 
	"STATUS" VARCHAR2(15 CHAR), 
	"ACQUISITION_DATE" DATE DEFAULT sysdate
   ) ;
--------------------------------------------------------
--  DDL for Table CATEGORY
--------------------------------------------------------

  CREATE TABLE "CATEGORY" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"NAME" VARCHAR2(100 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LIBRARIAN
--------------------------------------------------------

  CREATE TABLE "LIBRARIAN" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"USERNAME" VARCHAR2(50 CHAR), 
	"PASSWORD_HASH" VARCHAR2(250 CHAR), 
	"FIRST_NAME" VARCHAR2(100 CHAR), 
	"LAST_NAME" VARCHAR2(100 CHAR), 
	"EMAIL" VARCHAR2(254 CHAR), 
	"IS_ACTIVE" CHAR(1 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table LOAN
--------------------------------------------------------

  CREATE TABLE "LOAN" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"BARCODE" NUMBER(13,0), 
	"MEMBER_ID" NUMBER(10,0), 
	"LIBRARIAN_ID" NUMBER(10,0), 
	"LOAN_DATE" DATE DEFAULT sysdate, 
	"DUE_DATE" DATE, 
	"RETURN_DATE" DATE, 
	"STATUS" VARCHAR2(15 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table MEMBER
--------------------------------------------------------

  CREATE TABLE "MEMBER" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"FIRST_NAME" VARCHAR2(100 CHAR), 
	"LAST_NAME" VARCHAR2(100 CHAR), 
	"EMAIL" VARCHAR2(254 CHAR), 
	"PHONE" VARCHAR2(16 CHAR), 
	"ADDRESS" VARCHAR2(200 CHAR), 
	"REGISTRATION_DATE" DATE DEFAULT sysdate, 
	"DATE_OF_BIRTH" DATE, 
	"STATUS" VARCHAR2(15 CHAR), 
	"SUSPENSION_END_DATE" DATE, 
	"NOTE" VARCHAR2(1000 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PUBLISHER
--------------------------------------------------------

  CREATE TABLE "PUBLISHER" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"NAME" VARCHAR2(100 CHAR), 
	"PHONE" VARCHAR2(16 CHAR), 
	"EMAIL" VARCHAR2(254 CHAR), 
	"WEBSITE" VARCHAR2(250 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table RESERVATION
--------------------------------------------------------

  CREATE TABLE "RESERVATION" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ISBN" VARCHAR2(13 CHAR), 
	"MEMBER_ID" NUMBER, 
	"RESERVATION_DATE" DATE DEFAULT sysdate, 
	"STATUS" VARCHAR2(15 CHAR), 
	"READY_DATE" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table SHELF
--------------------------------------------------------

  CREATE TABLE "SHELF" 
   (	"ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"CODE" VARCHAR2(100 CHAR), 
	"FLOOR" VARCHAR2(20 CHAR), 
	"SECTION" VARCHAR2(100 CHAR)
   ) ;
