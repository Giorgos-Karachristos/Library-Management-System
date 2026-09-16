--------------------------------------------------------
--  DDL for Index AUTHOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "AUTHOR_PK" ON "AUTHOR" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index BOOK_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BOOK_PK" ON "BOOK" ("ISBN") 
  ;
--------------------------------------------------------
--  DDL for Index BOOKAUTHOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BOOKAUTHOR_PK" ON "BOOK_AUTHOR" ("ISBN", "AUTHOR_ID") 
  ;
--------------------------------------------------------
--  DDL for Index BOOKCATEGORY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BOOKCATEGORY_PK" ON "BOOK_CATEGORY" ("ISBN", "CATEGORY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index BOOK_COPY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BOOK_COPY_PK" ON "BOOK_COPY" ("BARCODE") 
  ;
--------------------------------------------------------
--  DDL for Index CATEGORY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CATEGORY_PK" ON "CATEGORY" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index CATEGORY_UK_NAME
--------------------------------------------------------

  CREATE UNIQUE INDEX "CATEGORY_UK_NAME" ON "CATEGORY" ("NAME") 
  ;
--------------------------------------------------------
--  DDL for Index LIBRARIAN_UK_EMAIL
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARIAN_UK_EMAIL" ON "LIBRARIAN" ("EMAIL") 
  ;
--------------------------------------------------------
--  DDL for Index LIBRARIAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARIAN_PK" ON "LIBRARIAN" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index LIBRARIAN_UK_USERNAME
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARIAN_UK_USERNAME" ON "LIBRARIAN" ("USERNAME") 
  ;
--------------------------------------------------------
--  DDL for Index LOAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LOAN_PK" ON "LOAN" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index MEMBER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MEMBER_PK" ON "MEMBER" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index PUBLISHER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PUBLISHER_PK" ON "PUBLISHER" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index PUBLISHER_UK_NAME
--------------------------------------------------------

  CREATE UNIQUE INDEX "PUBLISHER_UK_NAME" ON "PUBLISHER" ("NAME") 
  ;
--------------------------------------------------------
--  DDL for Index RESERVATION_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "RESERVATION_PK" ON "RESERVATION" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SHELF_UK_CODE
--------------------------------------------------------

  CREATE UNIQUE INDEX "SHELF_UK_CODE" ON "SHELF" ("CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SHELF_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SHELF_PK" ON "SHELF" ("ID") 
  ;
