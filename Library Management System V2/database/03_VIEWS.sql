--------------------------------------------------------
--  DDL for View VIEW_AUTHOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_AUTHOR" ("ID", "FIRST_NAME", "LAST_NAME", "BIRTH_YEAR") AS 
  SELECT id, first_name, last_name, birth_year
    
FROM AUTHOR
;
--------------------------------------------------------
--  DDL for View VIEW_BOOK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_BOOK" ("ISBN", "TITLE", "SUBTITLE", "PUBLICATION_YEAR", "EDITION", "BOOK_LANGUAGE", "PAGE_COUNT", "SUMMARY", "COVER_IMAGE_PATH", "IS_ACTIVE", "PUBLISHER_ID", "NAME") AS 
  SELECT B.ISBN, B.TITLE, B.SUBTITLE, B.PUBLICATION_YEAR, B.EDITION, B.BOOK_LANGUAGE, B.PAGE_COUNT, B.SUMMARY, B.COVER_IMAGE_PATH, B.IS_ACTIVE, B.PUBLISHER_ID, P.NAME
FROM BOOK B JOIN PUBLISHER P ON B.PUBLISHER_ID = P.ID
;
--------------------------------------------------------
--  DDL for View VIEW_BOOK_AUTHOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_BOOK_AUTHOR" ("ISBN", "AUTHOR_ID", "TITLE", "FIRST_NAME", "LAST_NAME") AS 
  SELECT ba.isbn, ba.author_id, b.title, a.first_name, a.last_name
    
FROM BOOK_AUTHOR ba JOIN BOOK b ON ba.isbn = b.isbn JOIN Author a ON ba.author_id = a.id
;
--------------------------------------------------------
--  DDL for View VIEW_BOOK_CATEGORY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_BOOK_CATEGORY" ("ISBN", "CATEGORY_ID", "TITLE", "NAME") AS 
  SELECT bc.isbn, bc.category_id, b.title, INITCAP(c.name) AS name
    
FROM BOOK_CATEGORY bc JOIN BOOK b ON bc.isbn = b.isbn JOIN Category c ON bc.category_id = c.id
;
--------------------------------------------------------
--  DDL for View VIEW_BOOK_COPY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_BOOK_COPY" ("BARCODE", "ISBN", "SHELF_ID", "STATUS", "ACQUISITION_DATE", "TITLE") AS 
  SELECT bc.barcode, bc.isbn, bc.shelf_id, bc.status, bc.acquisition_date, b.title
    
FROM BOOK_COPY bc JOIN BOOK b ON bc.isbn = b.isbn
;
--------------------------------------------------------
--  DDL for View VIEW_CATEGORY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_CATEGORY" ("ID", "NAME") AS 
  SELECT ID, NAME
    
FROM CATEGORY
;
--------------------------------------------------------
--  DDL for View VIEW_LIBRARIAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_LIBRARIAN" ("ID", "USERNAME", "FIRST_NAME", "LAST_NAME", "EMAIL", "IS_ACTIVE") AS 
  SELECT id, username, first_name, last_name, email, is_active
    
FROM LIBRARIAN
;
--------------------------------------------------------
--  DDL for View VIEW_LOAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_LOAN" ("ID", "BARCODE", "MEMBER_ID", "LIBRARIAN_ID", "LOAN_DATE", "DUE_DATE", "RETURN_DATE", "STATUS", "MEMBER_FIRST_NAME", "MEMBER_LAST_NAME", "LIBRARIAN_FIRST_NAME", "LIBRARIAN_LAST_NAME", "TITLE") AS 
  SELECT l.id, l.barcode, l.member_id, l.librarian_id, l.loan_date, l.due_date, 
l.return_date, l.status, m.first_name as member_first_name, m.last_name as member_last_name,
lib.first_name as librarian_first_name, lib.last_name as librarian_last_name, b.title 
    
FROM loan l join member m on l.member_id = m.id 
join librarian lib on  l.librarian_id = lib.id
join book_copy bc on  l.barcode = bc.barcode
join book b on bc.isbn = b.isbn
;
--------------------------------------------------------
--  DDL for View VIEW_MEMBER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_MEMBER" ("ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE", "ADDRESS", "REGISTRATION_DATE", "DATE_OF_BIRTH", "STATUS", "SUSPENSION_END_DATE", "NOTE") AS 
  SELECT id, first_name, last_name, email, phone, address, registration_date, date_of_birth, status, suspension_end_date, note 
    
FROM MEMBER
;
--------------------------------------------------------
--  DDL for View VIEW_PUBLISHER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_PUBLISHER" ("ID", "NAME", "PHONE", "EMAIL", "WEBSITE") AS 
  SELECT ID, NAME, PHONE, EMAIL, WEBSITE
    
FROM PUBLISHER
;
--------------------------------------------------------
--  DDL for View VIEW_RESERVATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_RESERVATION" ("ID", "ISBN", "MEMBER_ID", "RESERVATION_DATE", "STATUS", "READY_DATE", "TITLE", "FIRST_NAME", "LAST_NAME") AS 
  SELECT r.id, r.isbn, r.member_id, r.reservation_date, r.status, r.ready_date, b.title, m.first_name, m.last_name
    
FROM reservation r join book b on r.isbn = b.isbn join member m on r.member_id = m.id
;
--------------------------------------------------------
--  DDL for View VIEW_SHELF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "VIEW_SHELF" ("ID", "CODE", "FLOOR", "SECTION") AS 
  SELECT id, code, floor, section
    
FROM shelf
;
