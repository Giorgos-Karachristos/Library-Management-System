--------------------------------------------------------
--  DDL for Package Body AUTHOR_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "AUTHOR_PKG" AS

    PROCEDURE insert_author (
        p_first_name IN author.first_name%TYPE,
        p_last_name  IN author.last_name%TYPE,
        p_birth_year IN author.birth_year%TYPE,
        p_message    OUT VARCHAR2
    ) AS
        v_first_name author.first_name%TYPE;
    BEGIN
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        IF p_birth_year = 0 THEN
            p_message := 'Birth year cannot be zero.';
            RETURN;
        END IF;
        INSERT INTO author (
            first_name,
            last_name,
            birth_year
        ) VALUES (
            v_first_name,
            TRIM(p_last_name),
            p_birth_year
        );

        p_message := 'Author inserted successfully.';
    END insert_author;

    PROCEDURE update_author (
        p_id         IN author.id%TYPE,
        p_first_name IN author.first_name%TYPE,
        p_last_name  IN author.last_name%TYPE,
        p_birth_year IN author.birth_year%TYPE,
        p_message    OUT VARCHAR2
    ) AS
        v_first_name author.first_name%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Author ID is required.';
            RETURN;
        END IF;
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        IF p_birth_year = 0 THEN
            p_message := 'Birth year cannot be zero.';
            RETURN;
        END IF;
        UPDATE author
        SET
            first_name = v_first_name,
            last_name = TRIM(p_last_name),
            birth_year = p_birth_year
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Author updated successfully.';
        ELSE
            p_message := 'Author not found.';
        END IF;

    END update_author;

    PROCEDURE delete_author (
        p_id      IN author.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Author ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_author
            WHERE
                    author_id = p_id
                AND ROWNUM = 1;

            p_message := 'This author cannot be deleted because there are books associated with them.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM author
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Author deleted successfully.';
        ELSE
            p_message := 'Author not found.';
        END IF;

    END delete_author;

END author_pkg;

/
--------------------------------------------------------
--  DDL for Package Body BOOK_AUTHOR_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BOOK_AUTHOR_PKG" AS

    PROCEDURE insert_book_author (
        p_isbn      IN book_author.isbn%TYPE,
        p_author_id IN book_author.author_id%TYPE,
        p_message   OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_author_id IS NULL THEN
            p_message := 'Author ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                author
            WHERE
                    id = p_author_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Author does not exist.';
                RETURN;
        END;

        INSERT INTO book_author (
            isbn,
            author_id
        ) VALUES (
            p_isbn,
            p_author_id
        );

        p_message := 'Book-Author association created successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'This Book-Author association already exists.';
    END insert_book_author;

    PROCEDURE delete_book_author (
        p_isbn      IN book_author.isbn%TYPE,
        p_author_id IN book_author.author_id%TYPE,
        p_message   OUT VARCHAR2
    ) AS
        v_exists  NUMBER;
        v_counter NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_author_id IS NULL THEN
            p_message := 'Author ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_author
            WHERE
                    isbn = p_isbn
                AND author_id = p_author_id;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book-Author association not found.';
                RETURN;
        END;

        SELECT
            COUNT(*)
        INTO v_counter
        FROM
            book_author
        WHERE
            isbn = p_isbn;

        IF v_counter = 1 THEN
            p_message := 'You cannot delete this Book-Author association because the book must have at least one author.';
            RETURN;
        END IF;
        DELETE FROM book_author
        WHERE
                isbn = p_isbn
            AND author_id = p_author_id;

        p_message := 'Book-Author association deleted successfully.';
    END delete_book_author;

END book_author_pkg;

/
--------------------------------------------------------
--  DDL for Package Body BOOK_CATEGORY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BOOK_CATEGORY_PKG" AS

    PROCEDURE insert_book_category (
        p_isbn        IN book_category.isbn%TYPE,
        p_category_id IN book_category.category_id%TYPE,
        p_message     OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_category_id IS NULL THEN
            p_message := 'Category ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                category
            WHERE
                    id = p_category_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Category does not exist.';
                RETURN;
        END;

        INSERT INTO book_category (
            isbn,
            category_id
        ) VALUES (
            p_isbn,
            p_category_id
        );

        p_message := 'Book-Category association created successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'This Book-Category association already exists.';
    END insert_book_category;

    PROCEDURE delete_book_category (
        p_isbn        IN book_category.isbn%TYPE,
        p_category_id IN book_category.category_id%TYPE,
        p_message     OUT VARCHAR2
    ) AS
        v_exists  NUMBER;
        v_counter NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_category_id IS NULL THEN
            p_message := 'Category ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_category
            WHERE
                    isbn = p_isbn
                AND category_id = p_category_id;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book-Category association not found.';
                RETURN;
        END;

        SELECT
            COUNT(*)
        INTO v_counter
        FROM
            book_category
        WHERE
            isbn = p_isbn;

        IF v_counter = 1 THEN
            p_message := 'You cannot delete this association because every book must belong to at least one category.';
            RETURN;
        END IF;
        DELETE FROM book_category
        WHERE
                isbn = p_isbn
            AND category_id = p_category_id;

        p_message := 'Book-Category association deleted successfully.';
    END delete_book_category;

END book_category_pkg;

/
--------------------------------------------------------
--  DDL for Package Body BOOK_COPY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BOOK_COPY_PKG" AS

    PROCEDURE insert_book_copy (
        p_barcode  IN book_copy.barcode%TYPE,
        p_isbn     IN book_copy.isbn%TYPE,
        p_shelf_id IN book_copy.shelf_id%TYPE,
        p_status   IN book_copy.status%TYPE,
        p_message  OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_barcode IS NULL THEN
            p_message := 'Barcode is required.';
            RETURN;
        END IF;
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_shelf_id IS NULL THEN
            p_message := 'Shelf ID is required.';
            RETURN;
        END IF;
        IF TRIM(p_status) IS NULL THEN
            p_message := 'Status is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                shelf
            WHERE
                    id = p_shelf_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Shelf ID does not exist.';
                RETURN;
        END;

        IF p_status NOT IN ( 'Available', 'Lost', 'Unavailable' ) THEN
            p_message := 'Invalid status value.';
            RETURN;
        END IF;

        INSERT INTO book_copy (
            barcode,
            isbn,
            shelf_id,
            status
        ) VALUES (
            p_barcode,
            p_isbn,
            p_shelf_id,
            p_status
        );

        p_message := 'Book copy created successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A book copy with the same barcode already exists.';
    END insert_book_copy;

    PROCEDURE update_book_copy (
        p_barcode  IN book_copy.barcode%TYPE,
        p_isbn     IN book_copy.isbn%TYPE,
        p_shelf_id IN book_copy.shelf_id%TYPE,
        p_status   IN book_copy.status%TYPE,
        p_message  OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_barcode IS NULL THEN
            p_message := 'Barcode is required.';
            RETURN;
        END IF;
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_shelf_id IS NULL THEN
            p_message := 'Shelf ID is required.';
            RETURN;
        END IF;
        IF TRIM(p_status) IS NULL THEN
            p_message := 'Status is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                shelf
            WHERE
                    id = p_shelf_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Shelf ID does not exist.';
                RETURN;
        END;

        IF p_status NOT IN ( 'Available', 'Lost', 'Unavailable' ) THEN
            p_message := 'Invalid status value.';
            RETURN;
        END IF;

        UPDATE book_copy
        SET
            isbn = p_isbn,
            shelf_id = p_shelf_id,
            status = p_status
        WHERE
            barcode = p_barcode;

        IF SQL%rowcount = 1 THEN
            p_message := 'Book copy updated successfully.';
        ELSE
            p_message := 'Book copy not found.';
        END IF;

    END update_book_copy;

    PROCEDURE delete_book_copy (
        p_barcode IN book_copy.barcode%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_barcode IS NULL THEN
            p_message := 'Barcode is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                loan
            WHERE
                    barcode = p_barcode
                AND ROWNUM = 1;

            p_message := 'You cannot delete this book copy because loans are associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM book_copy
        WHERE
            barcode = p_barcode;

        IF SQL%rowcount = 1 THEN
            p_message := 'Book copy deleted successfully.';
        ELSE
            p_message := 'Book copy not found.';
        END IF;

    END delete_book_copy;

END book_copy_pkg;

/
--------------------------------------------------------
--  DDL for Package Body BOOK_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BOOK_PKG" AS

    PROCEDURE insert_book (
        p_isbn             IN book.isbn%TYPE,
        p_title            IN book.title%TYPE,
        p_subtitle         IN book.subtitle%TYPE,
        p_publication_year IN book.publication_year%TYPE,
        p_edition          IN book.edition%TYPE,
        p_book_language    IN book.book_language%TYPE,
        p_page_count       IN book.page_count%TYPE,
        p_summary          IN book.summary%TYPE,
        p_cover_image_path IN book.cover_image_path%TYPE,
        p_is_active        IN book.is_active%TYPE,
        p_publisher_id     IN book.publisher_id%TYPE,
        p_message          OUT VARCHAR2
    ) AS

        v_title         book.title%TYPE;
        v_book_language book.book_language%TYPE;
        v_is_active     book.is_active%TYPE;
        v_exists        NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        v_title := trim(p_title);
        IF v_title IS NULL THEN
            p_message := 'Title is required.';
            RETURN;
        END IF;
        v_book_language := trim(p_book_language);
        IF v_book_language IS NULL THEN
            p_message := 'Book language is required.';
            RETURN;
        END IF;
        IF p_page_count IS NULL THEN
            p_message := 'Page count is required.';
            RETURN;
        END IF;
        v_is_active := trim(p_is_active);
        IF v_is_active IS NULL THEN
            p_message := 'Is active is required.';
            RETURN;
        END IF;
        IF p_publisher_id IS NULL THEN
            p_message := 'Publisher ID is required.';
            RETURN;
        END IF;
        IF p_publication_year = 0 THEN
            p_message := 'Publication year cannot be zero.';
            RETURN;
        END IF;
        IF p_page_count <= 0 THEN
            p_message := 'Page count must be greater than zero.';
            RETURN;
        END IF;
        IF v_is_active NOT IN ( 'Y', 'N' ) THEN
            p_message := 'Invalid is active value.';
            RETURN;
        END IF;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                publisher
            WHERE
                    id = p_publisher_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Publisher does not exist.';
                RETURN;
        END;

        INSERT INTO book (
            isbn,
            title,
            subtitle,
            publication_year,
            edition,
            book_language,
            page_count,
            summary,
            cover_image_path,
            is_active,
            publisher_id
        ) VALUES (
            p_isbn,
            v_title,
            TRIM(p_subtitle),
            p_publication_year,
            TRIM(p_edition),
            v_book_language,
            p_page_count,
            TRIM(p_summary),
            TRIM(p_cover_image_path),
            v_is_active,
            p_publisher_id
        );

        p_message := 'Book inserted successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A book with the same ISBN already exists.';
    END insert_book;

    PROCEDURE update_book (
        p_isbn             IN book.isbn%TYPE,
        p_title            IN book.title%TYPE,
        p_subtitle         IN book.subtitle%TYPE,
        p_publication_year IN book.publication_year%TYPE,
        p_edition          IN book.edition%TYPE,
        p_book_language    IN book.book_language%TYPE,
        p_page_count       IN book.page_count%TYPE,
        p_summary          IN book.summary%TYPE,
        p_cover_image_path IN book.cover_image_path%TYPE,
        p_is_active        IN book.is_active%TYPE,
        p_publisher_id     IN book.publisher_id%TYPE,
        p_message          OUT VARCHAR2
    ) AS

        v_title         book.title%TYPE;
        v_book_language book.book_language%TYPE;
        v_is_active     book.is_active%TYPE;
        v_exists        NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        v_title := trim(p_title);
        IF v_title IS NULL THEN
            p_message := 'Title is required.';
            RETURN;
        END IF;
        v_book_language := trim(p_book_language);
        IF v_book_language IS NULL THEN
            p_message := 'Book language is required.';
            RETURN;
        END IF;
        IF p_page_count IS NULL THEN
            p_message := 'Page count is required.';
            RETURN;
        END IF;
        v_is_active := trim(p_is_active);
        IF v_is_active IS NULL THEN
            p_message := 'Is active is required.';
            RETURN;
        END IF;
        IF p_publisher_id IS NULL THEN
            p_message := 'Publisher is required.';
            RETURN;
        END IF;
        IF p_publication_year = 0 THEN
            p_message := 'Publication year cannot be zero.';
            RETURN;
        END IF;
        IF p_page_count <= 0 THEN
            p_message := 'Page count must be greater than zero.';
            RETURN;
        END IF;
        IF v_is_active NOT IN ( 'Y', 'N' ) THEN
            p_message := 'Invalid is active value.';
            RETURN;
        END IF;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                publisher
            WHERE
                    id = p_publisher_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Publisher does not exist.';
                RETURN;
        END;

        UPDATE book
        SET
            title = v_title,
            subtitle = TRIM(p_subtitle),
            publication_year = p_publication_year,
            edition = TRIM(p_edition),
            book_language = v_book_language,
            page_count = p_page_count,
            summary = TRIM(p_summary),
            cover_image_path = TRIM(p_cover_image_path),
            is_active = v_is_active,
            publisher_id = p_publisher_id
        WHERE
            isbn = p_isbn;

        IF SQL%rowcount = 1 THEN
            p_message := 'Book updated successfully.';
        ELSE
            p_message := 'Book not found.';
        END IF;

    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A book with the same ISBN already exists.';
    END update_book;

    PROCEDURE delete_book (
        p_isbn    IN book.isbn%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_copy
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

            p_message := 'You cannot delete this book because copies are associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                reservation
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

            p_message := 'You cannot delete this book because reservations are associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM book
        WHERE
            isbn = p_isbn;

        IF SQL%rowcount = 1 THEN
            p_message := 'Book deleted successfully.';
        ELSE
            p_message := 'Book not found.';
        END IF;

    END delete_book;

END book_pkg;

/
--------------------------------------------------------
--  DDL for Package Body CATEGORY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "CATEGORY_PKG" AS

    PROCEDURE insert_category (
        p_name    IN category.name%TYPE,
        p_message OUT VARCHAR2
    ) AS
    BEGIN
        IF TRIM(p_name) IS NULL THEN
            p_message := 'Category name is required.';
            RETURN;
        END IF;
        INSERT INTO category ( name ) VALUES ( p_name );

        p_message := 'Category inserted successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A category with the same name already exists.';
    END insert_category;

    PROCEDURE update_category (
        p_id      IN category.id%TYPE,
        p_name    IN category.name%TYPE,
        p_message OUT VARCHAR2
    ) AS
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Category id is required.';
            RETURN;
        END IF;
        IF TRIM(p_name) IS NULL THEN
            p_message := 'Category name is required.';
            RETURN;
        END IF;
        UPDATE category
        SET
            name = p_name
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Category updated successfully.';
        ELSE
            p_message := 'Category not found.';
        END IF;

    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A category with the same name already exists.';
    END update_category;

    PROCEDURE delete_category (
        p_id      IN category.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Category ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_category
            WHERE
                    category_id = p_id
                AND ROWNUM = 1;

            p_message := 'This category cannot be deleted because there are books associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM category
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Category deleted successfully.';
        ELSE
            p_message := 'Category not found.';
        END IF;

    END delete_category;

END category_pkg;

/
--------------------------------------------------------
--  DDL for Package Body LIBRARIAN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "LIBRARIAN_PKG" AS

    PROCEDURE insert_librarian (
        p_username      IN librarian.username%TYPE,
        p_password_hash IN librarian.password_hash%TYPE,
        p_first_name    IN librarian.first_name%TYPE,
        p_last_name     IN librarian.last_name%TYPE,
        p_email         IN librarian.email%TYPE,
        p_message       OUT VARCHAR2
    ) AS

        v_username      librarian.username%TYPE;
        v_password_hash librarian.password_hash%TYPE;
        v_first_name    librarian.first_name%TYPE;
        v_last_name     librarian.last_name%TYPE;
        v_email         librarian.email%TYPE;
        v_exists        NUMBER;
    BEGIN
        v_username := lower(trim(p_username));
        IF v_username IS NULL THEN
            p_message := 'Username is required.';
            RETURN;
        END IF;
        v_password_hash := trim(p_password_hash);
        IF v_password_hash IS NULL THEN
            p_message := 'Password hash is required.';
            RETURN;
        END IF;
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        v_last_name := trim(p_last_name);
        IF v_last_name IS NULL THEN
            p_message := 'Last name is required.';
            RETURN;
        END IF;
        v_email := lower(trim(p_email));
        IF v_email IS NULL THEN
            p_message := 'Email is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                librarian
            WHERE
                    username = v_username
                AND ROWNUM = 1;

            p_message := 'A librarian with the same username already exists.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        IF NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                librarian
            WHERE
                    email = v_email
                AND ROWNUM = 1;

            p_message := 'A librarian with the same email already exists.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        INSERT INTO librarian (
            username,
            password_hash,
            first_name,
            last_name,
            email,
            is_active
        ) VALUES (
            v_username,
            v_password_hash,
            v_first_name,
            v_last_name,
            v_email,
            'Y'
        );

        p_message := 'Librarian inserted successfully.';
    END insert_librarian;

    PROCEDURE update_librarian (
        p_id         IN librarian.id%TYPE,
        p_username   IN librarian.username%TYPE,
        p_first_name IN librarian.first_name%TYPE,
        p_last_name  IN librarian.last_name%TYPE,
        p_email      IN librarian.email%TYPE,
        p_message    OUT VARCHAR2
    ) AS

        v_username   librarian.username%TYPE;
        v_first_name librarian.first_name%TYPE;
        v_last_name  librarian.last_name%TYPE;
        v_email      librarian.email%TYPE;
        v_exists     NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Librarian ID is required.';
            RETURN;
        END IF;
        v_username := lower(trim(p_username));
        IF v_username IS NULL THEN
            p_message := 'Username is required.';
            RETURN;
        END IF;
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        v_last_name := trim(p_last_name);
        IF v_last_name IS NULL THEN
            p_message := 'Last name is required.';
            RETURN;
        END IF;
        v_email := lower(trim(p_email));
        IF v_email IS NULL THEN
            p_message := 'Email is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                librarian
            WHERE
                    username = v_username
                AND id != p_id
                AND ROWNUM = 1;

            p_message := 'A librarian with the same username already exists.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;
        
        IF NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                librarian
            WHERE
                    email = v_email
                AND id != p_id
                AND ROWNUM = 1;

            p_message := 'A librarian with the same email already exists.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        UPDATE librarian
        SET
            username = v_username,
            first_name = v_first_name,
            last_name = v_last_name,
            email = v_email
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Librarian updated successfully.';
        ELSE
            p_message := 'Librarian not found.';
        END IF;

    END update_librarian;

    PROCEDURE update_librarian_status (
        p_id        IN librarian.id%TYPE,
        p_is_active IN librarian.is_active%TYPE,
        p_message   OUT VARCHAR2
    ) AS
        v_exists    NUMBER;
        v_is_active librarian.is_active%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Librarian ID is required.';
            RETURN;
        END IF;
        v_is_active := upper(trim(p_is_active));
        IF v_is_active IS NULL THEN
            p_message := 'Is active is required.';
            RETURN;
        END IF;
        IF v_is_active NOT IN ( 'Y', 'N' ) THEN
            p_message := 'Invalid is active value.';
            RETURN;
        END IF;

        IF v_is_active = 'N' THEN
            BEGIN
                SELECT
                    1
                INTO v_exists
                FROM
                    librarian
                WHERE
                        is_active = 'Y'
                    AND id <> p_id
                    AND ROWNUM = 1;

            EXCEPTION
                WHEN no_data_found THEN
                    p_message := 'You cannot deactivate the last active librarian.';
                    RETURN;
            END;
        END IF;

        UPDATE librarian
        SET
            is_active = v_is_active
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Librarian status updated successfully.';
        ELSE
            p_message := 'Librarian not found.';
        END IF;

    END update_librarian_status;

    PROCEDURE update_librarian_password (
        p_username          IN librarian.username%TYPE,
        p_old_password_hash IN librarian.password_hash%TYPE,
        p_new_password_hash IN librarian.password_hash%TYPE,
        p_message           OUT VARCHAR2
    ) AS

        v_username          librarian.username%TYPE;
        v_old_password_hash librarian.password_hash%TYPE;
        v_new_password_hash librarian.password_hash%TYPE;
    BEGIN
        v_username := lower(trim(p_username));
        IF v_username IS NULL THEN
            p_message := 'Username is required.';
            RETURN;
        END IF;
        v_old_password_hash := trim(p_old_password_hash);
        IF v_old_password_hash IS NULL THEN
            p_message := 'Password hash is required.';
            RETURN;
        END IF;
        v_new_password_hash := trim(p_new_password_hash);
        IF v_new_password_hash IS NULL THEN
            p_message := 'Password hash is required.';
            RETURN;
        END IF;
        UPDATE librarian
        SET
            password_hash = v_new_password_hash
        WHERE
                username = v_username
            AND password_hash = v_old_password_hash
            AND is_active = 'Y';

        IF SQL%rowcount = 1 THEN
            p_message := 'Librarian password updated successfully.';
        ELSE
            p_message := 'Incorrect password.';
        END IF;

    END update_librarian_password;

    PROCEDURE delete_librarian (
        p_id      IN librarian.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Librarian ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                loan
            WHERE
                    librarian_id = p_id
                AND ROWNUM = 1;

            p_message := 'You cannot delete this librarian because there are loans associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM librarian
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Librarian deleted successfully.';
        ELSE
            p_message := 'Librarian not found.';
        END IF;

    END delete_librarian;

END librarian_pkg;

/
--------------------------------------------------------
--  DDL for Package Body LOAN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "LOAN_PKG" AS

    PROCEDURE insert_loan (
        p_barcode      IN loan.barcode%TYPE,
        p_member_id    IN loan.member_id%TYPE,
        p_librarian_id IN loan.librarian_id%TYPE,
        p_due_date     IN loan.due_date%TYPE,
        p_message      OUT VARCHAR2
    ) AS
        v_exists  NUMBER;
        v_isbn    book_copy.isbn%TYPE;
        v_counter NUMBER;
        v_id      reservation.id%TYPE;
    BEGIN
        IF p_barcode IS NULL THEN
            p_message := 'Barcode is required.';
            RETURN;
        END IF;
        IF p_member_id IS NULL THEN
            p_message := 'Member ID is required.';
            RETURN;
        END IF;
        IF p_librarian_id IS NULL THEN
            p_message := 'Librarian ID is required.';
            RETURN;
        END IF;
        IF p_due_date IS NULL THEN
            p_message := 'Due date is required.';
            RETURN;
        END IF;
        
        --Check book copy is Available and the book is Active
        BEGIN
            SELECT
                bc.isbn
            INTO v_isbn
            FROM
                     book_copy bc
                JOIN book b ON b.isbn = bc.isbn
            WHERE
                    bc.barcode = p_barcode
                AND b.is_active = 'Y'
                AND ( bc.status = 'Available'
                      OR ( bc.status = 'Reserved'
                           AND EXISTS (
                    SELECT
                        1
                    FROM
                        reservation r
                    WHERE
                            r.member_id = p_member_id
                        AND r.isbn = bc.isbn
                        AND r.status = 'Ready'
                ) ) );

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book copy is not available for loan.';
                RETURN;
        END;
        
        --Check member is Active
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                member
            WHERE
                    id = p_member_id
                AND status = 'Active';

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Member is Inactive or Suspended.';
                RETURN;
        END;
        
        --Check librarian is Active
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                librarian
            WHERE
                    id = p_librarian_id
                AND is_active = 'Y';

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Librarian is inactive.';
                RETURN;
        END;

        --Check member doesn't already have this book copy on loan
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                loan
            WHERE
                    barcode = p_barcode
                AND status = 'Active'
                AND member_id = p_member_id
                AND ROWNUM = 1;

            p_message := 'The same member cannot loan the same book copy twice.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        --Check member doesn't already have a different book copy of the same ISBN
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                     loan l
                JOIN book_copy bc ON l.barcode = bc.barcode
            WHERE
                    l.member_id = p_member_id
                AND l.status = 'Active'
                AND bc.isbn = v_isbn
                AND ROWNUM = 1;

            p_message := 'The same member can not loan a different book copy of the same ISBN twice.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        --Check member has fewer than 8 active loans
        SELECT
            COUNT(*)
        INTO v_counter
        FROM
            loan
        WHERE
                status = 'Active'
            AND member_id = p_member_id;

        IF v_counter >= 8 THEN
            p_message := 'You cannot loan more than 8 books.';
            RETURN;
        END IF;
        
        --Insert loan
        INSERT INTO loan (
            barcode,
            member_id,
            librarian_id,
            due_date,
            status
        ) VALUES (
            p_barcode,
            p_member_id,
            p_librarian_id,
            p_due_date,
            'Active'
        );

        --If this member has a READY reservation for this ISBN change it to Fulfilled
        BEGIN
            SELECT
                id
            INTO v_id
            FROM
                reservation
            WHERE
                    member_id = p_member_id
                AND isbn = v_isbn
                AND status = 'Ready'
            ORDER BY
                reservation_date,
                id
            FETCH FIRST 1 ROW ONLY;

        EXCEPTION
            WHEN no_data_found THEN
                v_id := NULL;
        END;

        IF v_id IS NOT NULL THEN
            UPDATE reservation
            SET
                status = 'Fulfilled'
            WHERE
                id = v_id;

            p_message := ' Associated reservation status updated successfully.';
        END IF;

        --Change book copy to Loaned
        UPDATE book_copy
        SET
            status = 'Loaned'
        WHERE
            barcode = p_barcode;

        p_message := 'Loan created successfully, and the book copy status was updated.' || p_message;
    END insert_loan;

    PROCEDURE update_loan_status (
        p_id      IN loan.id%TYPE,
        p_status  IN loan.status%TYPE,
        p_message OUT VARCHAR2
    ) AS

        v_old_status loan.status%TYPE;
        v_new_status loan.status%TYPE;
        v_barcode    loan.barcode%TYPE;
        v_isbn       book_copy.isbn%TYPE;
        v_id         reservation.id%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Loan ID is required.';
            RETURN;
        END IF;
        
        -- Validate new status
        v_new_status := initcap(trim(p_status));
        IF v_new_status NOT IN ( 'Returned', 'Lost', 'Cancelled' ) THEN
            p_message := 'Invalid loan status.';
            RETURN;
        END IF;
        
        -- Get current loan status and barcode
        BEGIN
            SELECT
                status,
                barcode
            INTO
                v_old_status,
                v_barcode
            FROM
                loan
            WHERE
                id = p_id;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Loan not found.';
                RETURN;
        END;

        -- Cannot change a non-active loan
        IF v_old_status != 'Active' THEN
            p_message := 'You cannot change the status of a non-active loan.';
            RETURN;
        END IF;
        
        -- Get ISBN of the borrowed copy
        SELECT
            isbn
        INTO v_isbn
        FROM
            book_copy
        WHERE
            barcode = v_barcode;
            
        -- Update the loan
        UPDATE loan
        SET
            status = v_new_status,
            return_date =
                CASE
                    WHEN v_new_status = 'Returned' THEN
                        sysdate
                    ELSE
                        NULL
                END
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Loan status updated successfully.';
        ELSE
            p_message := 'Loan not found.';
            RETURN;
        END IF;

        /* Only a returned copy can make an active reservation Ready.
        Find the oldest active reservation for this ISBN. */
        IF v_new_status = 'Returned' THEN
            BEGIN
                SELECT
                    id
                INTO v_id
                FROM
                    reservation
                WHERE
                        status = 'Active'
                    AND isbn = v_isbn
                ORDER BY
                    reservation_date,
                    id
                FETCH FIRST 1 ROW ONLY;

            EXCEPTION
                WHEN no_data_found THEN
                    v_id := NULL;
            END;
            -- If a reservation exists, make it Ready
            IF v_id IS NOT NULL THEN
                UPDATE reservation
                SET
                    status = 'Ready',
                    ready_date = sysdate
                WHERE
                    id = v_id;

                p_message := p_message || ' Oldest reservation updated successfully.';
            END IF;

        END IF;

        --Change book copy status
        UPDATE book_copy
        SET
            status =
                CASE
                    WHEN v_new_status = 'Lost' THEN
                        'Lost'
                    WHEN v_new_status = 'Returned'
                         AND v_id IS NOT NULL THEN
                        'Reserved'
                    WHEN v_new_status IN ( 'Returned', 'Cancelled' ) THEN
                        'Available'
                    ELSE
                        status
                END
        WHERE
            barcode = v_barcode;

        p_message := p_message || ' Book copy status updated successfully.';
    END update_loan_status;

END loan_pkg;

/
--------------------------------------------------------
--  DDL for Package Body MEMBER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "MEMBER_PKG" AS

    PROCEDURE insert_member (
        p_first_name          IN member.first_name%TYPE,
        p_last_name           IN member.last_name%TYPE,
        p_email               IN member.email%TYPE,
        p_phone               IN member.phone%TYPE,
        p_address             IN member.address%TYPE,
        p_date_of_birth       IN member.date_of_birth%TYPE,
        p_status              IN member.status%TYPE,
        p_suspension_end_date IN member.suspension_end_date%TYPE,
        p_note                IN member.note%TYPE,
        p_message             OUT VARCHAR2
    ) AS

        v_first_name member.first_name%TYPE;
        v_last_name  member.last_name%TYPE;
        v_email      member.email%TYPE;
        v_phone      member.phone%TYPE;
        v_address    member.address%TYPE;
        v_status     member.status%TYPE;
    BEGIN
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        v_last_name := trim(p_last_name);
        IF v_last_name IS NULL THEN
            p_message := 'Last name is required.';
            RETURN;
        END IF;
        v_email := trim(p_email);
        IF v_email IS NULL THEN
            p_message := 'Email is required.';
            RETURN;
        END IF;
        v_phone := trim(p_phone);
        IF v_phone IS NULL THEN
            p_message := 'Phone is required.';
            RETURN;
        END IF;
        v_address := trim(p_address);
        IF v_address IS NULL THEN
            p_message := 'Address is required.';
            RETURN;
        END IF;
        IF p_date_of_birth IS NULL THEN
            p_message := 'Date of birth is required.';
            RETURN;
        END IF;
        v_status := trim(p_status);
        IF v_status IS NULL THEN
            p_message := 'Status is required.';
            RETURN;
        END IF;
        IF NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        IF NOT is_it_valid(v_phone, '^\+?[1-9][0-9]{6,14}$') THEN
            p_message := 'Please enter a valid phone number.';
            RETURN;
        END IF;

        IF v_status NOT IN ( 'Active', 'Inactive', 'Suspended' ) THEN
            p_message := 'Invalid is status value.';
            RETURN;
        END IF;

        IF (
            v_status = 'Suspended'
            AND p_suspension_end_date IS NULL
        ) OR (
            v_status IN ( 'Active', 'Inactive' )
            AND p_suspension_end_date IS NOT NULL
        ) THEN
            p_message := 'Invalid status and suspension end date combination.';
            RETURN;
        END IF;

        INSERT INTO member (
            first_name,
            last_name,
            email,
            phone,
            address,
            date_of_birth,
            status,
            suspension_end_date,
            note
        ) VALUES (
            v_first_name,
            v_last_name,
            v_email,
            v_phone,
            v_address,
            p_date_of_birth,
            v_status,
            p_suspension_end_date,
            TRIM(p_note)
        );

        p_message := 'Member inserted successfully.';
    END insert_member;

    PROCEDURE update_member (
        p_id                  IN member.id%TYPE,
        p_first_name          IN member.first_name%TYPE,
        p_last_name           IN member.last_name%TYPE,
        p_email               IN member.email%TYPE,
        p_phone               IN member.phone%TYPE,
        p_address             IN member.address%TYPE,
        p_date_of_birth       IN member.date_of_birth%TYPE,
        p_status              IN member.status%TYPE,
        p_suspension_end_date IN member.suspension_end_date%TYPE,
        p_note                IN member.note%TYPE,
        p_message             OUT VARCHAR2
    ) AS

        v_first_name member.first_name%TYPE;
        v_last_name  member.last_name%TYPE;
        v_email      member.email%TYPE;
        v_phone      member.phone%TYPE;
        v_address    member.address%TYPE;
        v_status     member.status%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Member ID is required.';
            RETURN;
        END IF;
        v_first_name := trim(p_first_name);
        IF v_first_name IS NULL THEN
            p_message := 'First name is required.';
            RETURN;
        END IF;
        v_last_name := trim(p_last_name);
        IF v_last_name IS NULL THEN
            p_message := 'Last name is required.';
            RETURN;
        END IF;
        v_email := trim(p_email);
        IF v_email IS NULL THEN
            p_message := 'Email is required.';
            RETURN;
        END IF;
        v_phone := trim(p_phone);
        IF v_phone IS NULL THEN
            p_message := 'Phone is required.';
            RETURN;
        END IF;
        v_address := trim(p_address);
        IF v_address IS NULL THEN
            p_message := 'Address is required.';
            RETURN;
        END IF;
        IF p_date_of_birth IS NULL THEN
            p_message := 'Date of birth is required.';
            RETURN;
        END IF;
        v_status := trim(p_status);
        IF v_status IS NULL THEN
            p_message := 'Status is required.';
            RETURN;
        END IF;
        IF NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        IF NOT is_it_valid(v_phone, '^\+?[1-9][0-9]{6,14}$') THEN
            p_message := 'Please enter a valid phone number.';
            RETURN;
        END IF;

        IF v_status NOT IN ( 'Active', 'Inactive', 'Suspended' ) THEN
            p_message := 'Invalid is status value.';
            RETURN;
        END IF;

        IF (
            v_status = 'Suspended'
            AND p_suspension_end_date IS NULL
        ) OR (
            v_status IN ( 'Active', 'Inactive' )
            AND p_suspension_end_date IS NOT NULL
        ) THEN
            p_message := 'Invalid status and suspension end date combination.';
            RETURN;
        END IF;

        UPDATE member
        SET
            first_name = v_first_name,
            last_name = v_last_name,
            email = v_email,
            phone = v_phone,
            address = v_address,
            date_of_birth = p_date_of_birth,
            status = v_status,
            suspension_end_date = p_suspension_end_date,
            note = TRIM(p_note)
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Member updated successfully.';
        ELSE
            p_message := 'Member not found.';
        END IF;

    END update_member;

    PROCEDURE delete_member (
        p_id      IN member.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Member ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                loan
            WHERE
                    member_id = p_id
                AND ROWNUM = 1;

            p_message := 'You cannot delete this member because there are loans associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                reservation
            WHERE
                    member_id = p_id
                AND ROWNUM = 1;

            p_message := 'You cannot delete this member because there are reservations associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM member
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Member deleted successfully.';
        ELSE
            p_message := 'Member not found.';
        END IF;

    END delete_member;

END member_pkg;

/
--------------------------------------------------------
--  DDL for Package Body PUBLISHER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PUBLISHER_PKG" AS

    PROCEDURE insert_publisher (
        p_name    IN publisher.name%TYPE,
        p_phone   IN publisher.phone%TYPE,
        p_email   IN publisher.email%TYPE,
        p_website IN publisher.website%TYPE,
        p_message OUT VARCHAR2
    ) AS

        v_name  publisher.name%TYPE;
        v_phone publisher.phone%TYPE;
        v_email publisher.email%TYPE;
    BEGIN
        v_name := trim(p_name);
        IF v_name IS NULL THEN
            p_message := 'Publisher name is required.';
            RETURN;
        END IF;
        v_phone := trim(p_phone);
        IF
            v_phone IS NOT NULL
            AND NOT is_it_valid(v_phone, '^\+?[1-9][0-9]{6,14}$')
        THEN
            p_message := 'Please enter a valid phone number.';
            RETURN;
        END IF;

        v_email := trim(p_email);
        IF
            v_email IS NOT NULL
            AND NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
        THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        INSERT INTO publisher (
            name,
            phone,
            email,
            website
        ) VALUES (
            v_name,
            v_phone,
            v_email,
            TRIM(p_website)
        );

        p_message := 'Publisher inserted successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A publisher with the same name already exists.';
    END insert_publisher;

    PROCEDURE update_publisher (
        p_id      IN publisher.id%TYPE,
        p_name    IN publisher.name%TYPE,
        p_phone   IN publisher.phone%TYPE,
        p_email   IN publisher.email%TYPE,
        p_website IN publisher.website%TYPE,
        p_message OUT VARCHAR2
    ) AS

        v_name  publisher.name%TYPE;
        v_phone publisher.phone%TYPE;
        v_email publisher.email%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Publisher ID is required.';
            RETURN;
        END IF;
        v_name := trim(p_name);
        IF v_name IS NULL THEN
            p_message := 'Publisher name is required.';
            RETURN;
        END IF;
        v_phone := trim(p_phone);
        IF
            v_phone IS NOT NULL
            AND NOT is_it_valid(v_phone, '^\+?[1-9][0-9]{6,14}$')
        THEN
            p_message := 'Please enter a valid phone number.';
            RETURN;
        END IF;

        v_email := trim(p_email);
        IF
            v_email IS NOT NULL
            AND NOT is_it_valid(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
        THEN
            p_message := 'Please enter a valid email address.';
            RETURN;
        END IF;

        UPDATE publisher
        SET
            name = v_name,
            phone = v_phone,
            email = v_email,
            website = TRIM(p_website)
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Publisher updated successfully.';
        ELSE
            p_message := 'Publisher not found.';
        END IF;

    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A publisher with the same name already exists.';
    END update_publisher;

    PROCEDURE delete_publisher (
        p_id      IN publisher.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Publisher ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    publisher_id = p_id
                AND ROWNUM = 1;

            p_message := 'This publisher cannot be deleted because there are books associated with it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM publisher
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Publisher deleted successfully.';
        ELSE
            p_message := 'Publisher not found.';
        END IF;

    END delete_publisher;

END publisher_pkg;

/
--------------------------------------------------------
--  DDL for Package Body RESERVATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "RESERVATION_PKG" AS

    PROCEDURE insert_reservation (
        p_isbn      IN reservation.isbn%TYPE,
        p_member_id IN reservation.member_id%TYPE,
        p_message   OUT VARCHAR2
    ) AS
        v_exists  NUMBER;
        v_counter NUMBER;
    BEGIN
        IF TRIM(p_isbn) IS NULL THEN
            p_message := 'ISBN is required.';
            RETURN;
        END IF;
        IF p_member_id IS NULL THEN
            p_message := 'Member ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Book does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book
            WHERE
                    isbn = p_isbn
                AND is_active = 'Y'
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'This book is inactive and cannot be reserved.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                member
            WHERE
                    id = p_member_id
                AND ROWNUM = 1;

        EXCEPTION
            WHEN no_data_found THEN
                p_message := 'Member does not exist.';
                RETURN;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                member
            WHERE
                    id = p_member_id
                AND ROWNUM = 1
                AND status IN ( 'Suspended', 'Inactive' );

            p_message := 'Suspended or Inactive members cannot reserve.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_copy
            WHERE
                    isbn = p_isbn
                AND status = 'Available'
                AND ROWNUM = 1;

            p_message := 'You can not reserve a book that currently has available copies.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                reservation
            WHERE
                    isbn = p_isbn
                AND status IN ( 'Active', 'Ready' )
                AND member_id = p_member_id
                AND ROWNUM = 1;

            p_message := 'The same member can not reserve the same book twice.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        SELECT
            COUNT(*)
        INTO v_counter
        FROM
            reservation
        WHERE
            status IN ( 'Active', 'Ready' )
            AND member_id = p_member_id;

        IF v_counter >= 4 THEN
            p_message := 'You cannot reserve more than 4 books.';
            RETURN;
        END IF;
        INSERT INTO reservation (
            isbn,
            member_id,
            status
        ) VALUES (
            p_isbn,
            p_member_id,
            'Active'
        );

        p_message := 'Reservation inserted successfully.';
    END insert_reservation;

    PROCEDURE update_reservation_status (
        p_id      IN reservation.id%TYPE,
        p_status  IN reservation.status%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_status     reservation.status%TYPE;
        v_new_status reservation.status%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Reservation ID is required.';
            RETURN;
        END IF;
        SELECT
            status
        INTO v_status
        FROM
            reservation
        WHERE
            id = p_id;

        v_new_status := initcap(trim(p_status));
        IF v_new_status IN ( 'Ready', 'Cancelled' ) THEN
            IF v_status != 'Active' THEN
                p_message := 'You cannot change the status of a non-active reservation.';
                RETURN;
            END IF;
        ELSIF v_new_status IN ( 'Fulfilled', 'Expired' ) THEN
            IF v_status != 'Ready' THEN
                p_message := 'You cannot change the status of a non-ready reservation.';
                RETURN;
            END IF;
        ELSE
            p_message := 'Invalid reservation status.';
            RETURN;
        END IF;

        UPDATE reservation
        SET
            status = v_new_status,
            ready_date =
                CASE
                    WHEN v_new_status = 'Ready' THEN
                        sysdate
                    ELSE
                        ready_date
                END
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Reservation status updated successfully.';
        ELSE
            p_message := 'Reservation not found.';
        END IF;

    EXCEPTION
        WHEN no_data_found THEN
            p_message := 'Reservation not found.';
    END update_reservation_status;

END reservation_pkg;

/
--------------------------------------------------------
--  DDL for Package Body SHELF_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SHELF_PKG" AS

    PROCEDURE insert_shelf (
        p_code    IN shelf.code%TYPE,
        p_floor   IN shelf.floor%TYPE,
        p_section IN shelf.section%TYPE,
        p_message OUT VARCHAR2
    ) AS

        v_code    shelf.code%TYPE;
        v_floor   shelf.floor%TYPE;
        v_section shelf.section%TYPE;
    BEGIN
        v_code := trim(p_code);
        IF v_code IS NULL THEN
            p_message := 'Code is required.';
            RETURN;
        END IF;
        v_floor := trim(p_floor);
        IF v_floor IS NULL THEN
            p_message := 'Floor is required.';
            RETURN;
        END IF;
        v_section := trim(p_section);
        IF v_section IS NULL THEN
            p_message := 'Section is required.';
            RETURN;
        END IF;
        INSERT INTO shelf (
            code,
            floor,
            section
        ) VALUES (
            v_code,
            v_floor,
            v_section
        );

        p_message := 'Shelf inserted successfully.';
    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A shelf with the same code already exists.';
    END insert_shelf;

    PROCEDURE update_shelf (
        p_id      IN shelf.id%TYPE,
        p_code    IN shelf.code%TYPE,
        p_floor   IN shelf.floor%TYPE,
        p_section IN shelf.section%TYPE,
        p_message OUT VARCHAR2
    ) AS

        v_code    shelf.code%TYPE;
        v_floor   shelf.floor%TYPE;
        v_section shelf.section%TYPE;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Shelf ID is required.';
            RETURN;
        END IF;
        v_code := trim(p_code);
        IF v_code IS NULL THEN
            p_message := 'Code is required.';
            RETURN;
        END IF;
        v_floor := trim(p_floor);
        IF v_floor IS NULL THEN
            p_message := 'Floor is required.';
            RETURN;
        END IF;
        v_section := trim(p_section);
        IF v_section IS NULL THEN
            p_message := 'Section is required.';
            RETURN;
        END IF;
        UPDATE shelf
        SET
            code = v_code,
            floor = v_floor,
            section = v_section
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Shelf updated successfully.';
        ELSE
            p_message := 'Shelf not found.';
        END IF;

    EXCEPTION
        WHEN dup_val_on_index THEN
            p_message := 'A shelf with the same code already exists.';
    END update_shelf;

    PROCEDURE delete_shelf (
        p_id      IN shelf.id%TYPE,
        p_message OUT VARCHAR2
    ) AS
        v_exists NUMBER;
    BEGIN
        IF p_id IS NULL THEN
            p_message := 'Shelf ID is required.';
            RETURN;
        END IF;
        BEGIN
            SELECT
                1
            INTO v_exists
            FROM
                book_copy
            WHERE
                    shelf_id = p_id
                AND ROWNUM = 1;

            p_message := 'You cannot delete this shelf because book copies are stored on it.';
            RETURN;
        EXCEPTION
            WHEN no_data_found THEN
                NULL;
        END;

        DELETE FROM shelf
        WHERE
            id = p_id;

        IF SQL%rowcount = 1 THEN
            p_message := 'Shelf deleted successfully.';
        ELSE
            p_message := 'Shelf not found.';
        END IF;
    END delete_shelf;

END shelf_pkg;

/
