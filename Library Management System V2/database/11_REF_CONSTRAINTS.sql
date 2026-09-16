--------------------------------------------------------
--  Ref Constraints for Table BOOK
--------------------------------------------------------

  ALTER TABLE "BOOK" ADD CONSTRAINT "BOOK_FK" FOREIGN KEY ("PUBLISHER_ID")
	  REFERENCES "PUBLISHER" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BOOK_AUTHOR
--------------------------------------------------------

  ALTER TABLE "BOOK_AUTHOR" ADD CONSTRAINT "BOOKAUTHOR_FK_AUTHOR_ID" FOREIGN KEY ("AUTHOR_ID")
	  REFERENCES "AUTHOR" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "BOOK_AUTHOR" ADD CONSTRAINT "BOOKAUTHOR_FK_ISBN" FOREIGN KEY ("ISBN")
	  REFERENCES "BOOK" ("ISBN") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BOOK_CATEGORY
--------------------------------------------------------

  ALTER TABLE "BOOK_CATEGORY" ADD CONSTRAINT "BOOKCATEGORY_FK_ISBN" FOREIGN KEY ("ISBN")
	  REFERENCES "BOOK" ("ISBN") ON DELETE CASCADE ENABLE;
  ALTER TABLE "BOOK_CATEGORY" ADD CONSTRAINT "BOOKCATEGORY_FK_CATEGORY_ID" FOREIGN KEY ("CATEGORY_ID")
	  REFERENCES "CATEGORY" ("ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BOOK_COPY
--------------------------------------------------------

  ALTER TABLE "BOOK_COPY" ADD CONSTRAINT "BOOK_COPY_FK_ISBN" FOREIGN KEY ("ISBN")
	  REFERENCES "BOOK" ("ISBN") ENABLE;
  ALTER TABLE "BOOK_COPY" ADD CONSTRAINT "BOOK_COPY_FK_SHELF_ID" FOREIGN KEY ("SHELF_ID")
	  REFERENCES "SHELF" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table LOAN
--------------------------------------------------------

  ALTER TABLE "LOAN" ADD CONSTRAINT "LOAN_FK_LIBRARIAN_ID" FOREIGN KEY ("LIBRARIAN_ID")
	  REFERENCES "LIBRARIAN" ("ID") ENABLE;
  ALTER TABLE "LOAN" ADD CONSTRAINT "LOAN_FK_MEMBER_ID" FOREIGN KEY ("MEMBER_ID")
	  REFERENCES "MEMBER" ("ID") ENABLE;
  ALTER TABLE "LOAN" ADD CONSTRAINT "LOAN_FK_BARCODE" FOREIGN KEY ("BARCODE")
	  REFERENCES "BOOK_COPY" ("BARCODE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESERVATION
--------------------------------------------------------

  ALTER TABLE "RESERVATION" ADD CONSTRAINT "RESERVATION_FK_MEMBER_ID" FOREIGN KEY ("MEMBER_ID")
	  REFERENCES "MEMBER" ("ID") ENABLE;
  ALTER TABLE "RESERVATION" ADD CONSTRAINT "RESERVATION_FK_ISBN" FOREIGN KEY ("ISBN")
	  REFERENCES "BOOK" ("ISBN") ENABLE;
