--------------------------------------------------------
--  DDL for Trigger AUTHOR_CHK_BIRTH_YEAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "AUTHOR_CHK_BIRTH_YEAR" BEFORE
    INSERT OR UPDATE OF birth_year ON author
    FOR EACH ROW
BEGIN
    IF :new.birth_year > extract(YEAR FROM sysdate) THEN
        raise_application_error(-20001, 'Birth year cannot be greater than the current year.');
    END IF;
END;
/
ALTER TRIGGER "AUTHOR_CHK_BIRTH_YEAR" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BOOK_CHK_PUBLICATION_YEAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BOOK_CHK_PUBLICATION_YEAR" BEFORE
    INSERT OR UPDATE OF publication_year ON book
    FOR EACH ROW
BEGIN
    IF :new.publication_year > extract(YEAR FROM sysdate) THEN
        raise_application_error(-20002, 'Publication year cannot be greater than the current year.');
    END IF;
END;
/
ALTER TRIGGER "BOOK_CHK_PUBLICATION_YEAR" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BOOK_NOR_ISBN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BOOK_NOR_ISBN" BEFORE
    INSERT OR UPDATE OF isbn ON book
    FOR EACH ROW
BEGIN
    :new.isbn := upper(regexp_replace(:new.isbn, '[- ]', ''));

    IF
        NOT regexp_like(:new.isbn, '^[0-9]{9}[0-9X]$')
        AND NOT regexp_like(:new.isbn, '^[0-9]{13}$')
    THEN
        raise_application_error(-20003, 'ISBN must be a valid ISBN-10 or ISBN-13 format.');
    END IF;

END;
/
ALTER TRIGGER "BOOK_NOR_ISBN" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CATEGORY_NOR_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CATEGORY_NOR_NAME" BEFORE
    INSERT OR UPDATE OF name ON category
    FOR EACH ROW
BEGIN
    :new.name := INITCAP(regexp_replace(trim(:new.name), '[[:space:]]+', ' '));
END;
/
ALTER TRIGGER "CATEGORY_NOR_NAME" ENABLE;
--------------------------------------------------------
--  DDL for Trigger LOAN_CHK_DUE_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "LOAN_CHK_DUE_DATE" BEFORE
    INSERT OR UPDATE OF due_date ON loan
    FOR EACH ROW
BEGIN
    IF :new.due_date <= sysdate THEN
        raise_application_error(-20007, 'Due date must be in the future.');
    END IF;
END;
/
ALTER TRIGGER "LOAN_CHK_DUE_DATE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger MEMBER_CHK_DATE_OF_BIRTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MEMBER_CHK_DATE_OF_BIRTH" BEFORE
    INSERT OR UPDATE OF date_of_birth ON member
    FOR EACH ROW
BEGIN
    IF trunc(:new.date_of_birth) >= trunc(sysdate) THEN
        raise_application_error(-20004, 'Date of birth cannot be today or in the future.');
    END IF;

    IF add_months(trunc(:new.date_of_birth), 1200) <= trunc(sysdate) THEN
        raise_application_error(-20005, 'Date of birth cannot indicate an age greater than 100.');
    END IF;

END;
/
ALTER TRIGGER "MEMBER_CHK_DATE_OF_BIRTH" ENABLE;
--------------------------------------------------------
--  DDL for Trigger MEMBER_CHK_SUSPENSION_END_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MEMBER_CHK_SUSPENSION_END_DATE" BEFORE
    INSERT OR UPDATE OF SUSPENSION_END_DATE ON member
    FOR EACH ROW
BEGIN
    IF :new.SUSPENSION_END_DATE < sysdate THEN
        raise_application_error(-20006, 'Suspension end date cannot be in the past.');
    END IF;
END;
/
ALTER TRIGGER "MEMBER_CHK_SUSPENSION_END_DATE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PUBLISHER_NOR_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PUBLISHER_NOR_NAME" BEFORE
    INSERT OR UPDATE OF name ON publisher
    FOR EACH ROW
BEGIN
    :new.name := lower(regexp_replace(trim(:new.name), '[[:space:]]+', ' '));
END;
/
ALTER TRIGGER "PUBLISHER_NOR_NAME" ENABLE;
