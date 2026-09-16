--------------------------------------------------------
--  DDL for Package AUTHOR_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "AUTHOR_PKG" AS
    PROCEDURE insert_author (
        p_first_name IN author.first_name%TYPE,
        p_last_name  IN author.last_name%TYPE,
        p_birth_year IN author.birth_year%TYPE,
        p_message    OUT VARCHAR2
    );

    PROCEDURE update_author (
        p_id         IN author.id%TYPE,
        p_first_name IN author.first_name%TYPE,
        p_last_name  IN author.last_name%TYPE,
        p_birth_year IN author.birth_year%TYPE,
        p_message    OUT VARCHAR2
    );

    PROCEDURE delete_author (
        p_id      IN author.id%TYPE,
        p_message OUT VARCHAR2
    );

END author_pkg;

/
--------------------------------------------------------
--  DDL for Package BOOK_AUTHOR_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BOOK_AUTHOR_PKG" AS
    PROCEDURE insert_book_author (
        p_isbn      IN book_author.isbn%TYPE,
        p_author_id IN book_author.author_id%TYPE,
        p_message   OUT VARCHAR2
    );

    PROCEDURE delete_book_author (
        p_isbn      IN book_author.isbn%TYPE,
        p_author_id IN book_author.author_id%TYPE,
        p_message   OUT VARCHAR2
    );

END book_author_pkg;

/
--------------------------------------------------------
--  DDL for Package BOOK_CATEGORY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BOOK_CATEGORY_PKG" AS
    PROCEDURE insert_book_category (
        p_isbn        IN book_category.isbn%TYPE,
        p_category_id IN book_category.category_id%TYPE,
        p_message     OUT VARCHAR2
    );

    PROCEDURE delete_book_category (
        p_isbn        IN book_category.isbn%TYPE,
        p_category_id IN book_category.category_id%TYPE,
        p_message     OUT VARCHAR2
    );

END book_category_pkg;

/
--------------------------------------------------------
--  DDL for Package BOOK_COPY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BOOK_COPY_PKG" AS
    PROCEDURE insert_book_copy (
        p_barcode          IN book_copy.barcode%TYPE,
        p_isbn             IN book_copy.isbn%TYPE,
        p_shelf_id         IN book_copy.shelf_id%TYPE,
        p_status           IN book_copy.status%TYPE,
        p_message          OUT VARCHAR2
    );

    PROCEDURE update_book_copy (
        p_barcode          IN book_copy.barcode%TYPE,
        p_isbn             IN book_copy.isbn%TYPE,
        p_shelf_id         IN book_copy.shelf_id%TYPE,
        p_status           IN book_copy.status%TYPE,
        p_message          OUT VARCHAR2
    );

    PROCEDURE delete_book_copy (
        p_barcode IN book_copy.barcode%TYPE,
        p_message OUT VARCHAR2
    );

END book_copy_pkg;

/
--------------------------------------------------------
--  DDL for Package BOOK_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BOOK_PKG" AS
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
    );

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
    );

    PROCEDURE delete_book (
        p_isbn    IN book.isbn%TYPE,
        p_message OUT VARCHAR2
    );

END book_pkg;

/
--------------------------------------------------------
--  DDL for Package CATEGORY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "CATEGORY_PKG" AS
    PROCEDURE insert_category (
        p_name    IN category.name%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE update_category (
        p_id      IN category.id%TYPE,
        p_name    IN category.name%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE delete_category (
        p_id      IN category.id%TYPE,
        p_message OUT VARCHAR2
    );

END category_pkg;

/
--------------------------------------------------------
--  DDL for Package LIBRARIAN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "LIBRARIAN_PKG" AS
    PROCEDURE insert_librarian (
        p_username      IN librarian.username%TYPE,
        p_password_hash IN librarian.password_hash%TYPE,
        p_first_name    IN librarian.first_name%TYPE,
        p_last_name     IN librarian.last_name%TYPE,
        p_email         IN librarian.email%TYPE,
        p_message       OUT VARCHAR2
    );

    PROCEDURE update_librarian (
        p_id         IN librarian.id%TYPE,
        p_username   IN librarian.username%TYPE,
        p_first_name IN librarian.first_name%TYPE,
        p_last_name  IN librarian.last_name%TYPE,
        p_email      IN librarian.email%TYPE,
        p_message    OUT VARCHAR2
    );

    PROCEDURE update_librarian_status (
        p_id        IN librarian.id%TYPE,
        p_is_active IN librarian.is_active%TYPE,
        p_message   OUT VARCHAR2
    );
    
    PROCEDURE update_librarian_password (
        p_username   IN librarian.username%TYPE,
        p_old_password_hash IN librarian.password_hash%TYPE,
        p_new_password_hash IN librarian.password_hash%TYPE,
        p_message   OUT VARCHAR2
    );

    PROCEDURE delete_librarian (
        p_id      IN librarian.id%TYPE,
        p_message OUT VARCHAR2
    );

END librarian_pkg;

/
--------------------------------------------------------
--  DDL for Package LOAN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "LOAN_PKG" AS
    PROCEDURE insert_loan (
        p_barcode      IN loan.barcode%TYPE,
        p_member_id    IN loan.member_id%TYPE,
        p_librarian_id IN loan.librarian_id%TYPE,
        p_due_date     IN loan.due_date%TYPE,
        p_message      OUT VARCHAR2
    );

    PROCEDURE update_loan_status (
        p_id      IN loan.id%TYPE,
        p_status  IN loan.status%TYPE,
        p_message OUT VARCHAR2
    );

END loan_pkg;

/
--------------------------------------------------------
--  DDL for Package MEMBER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "MEMBER_PKG" AS
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
    );

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
    );

    PROCEDURE delete_member (
        p_id      IN member.id%TYPE,
        p_message OUT VARCHAR2
    );

END member_pkg;

/
--------------------------------------------------------
--  DDL for Package PUBLISHER_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PUBLISHER_PKG" AS
    PROCEDURE insert_publisher (
        p_name    IN publisher.name%TYPE,
        p_phone   IN publisher.phone%TYPE,
        p_email   IN publisher.email%TYPE,
        p_website IN publisher.website%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE update_publisher (
        p_id      IN publisher.id%TYPE,
        p_name    IN publisher.name%TYPE,
        p_phone   IN publisher.phone%TYPE,
        p_email   IN publisher.email%TYPE,
        p_website IN publisher.website%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE delete_publisher (
        p_id      IN publisher.id%TYPE,
        p_message OUT VARCHAR2
    );

END publisher_pkg;

/
--------------------------------------------------------
--  DDL for Package RESERVATION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "RESERVATION_PKG" AS
    PROCEDURE insert_reservation (
        p_isbn      IN reservation.isbn%TYPE,
        p_member_id IN reservation.member_id%TYPE,
        p_message   OUT VARCHAR2
    );

    PROCEDURE update_reservation_status (
        p_id      IN reservation.id%TYPE,
        p_status  IN reservation.status%TYPE,
        p_message OUT VARCHAR2
    );

END reservation_pkg;

/
--------------------------------------------------------
--  DDL for Package SHELF_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SHELF_PKG" AS
    PROCEDURE insert_shelf (
        p_code    IN shelf.code%TYPE,
        p_floor   IN shelf.floor%TYPE,
        p_section IN shelf.section%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE update_shelf (
        p_id      IN shelf.id%TYPE,
        p_code    IN shelf.code%TYPE,
        p_floor   IN shelf.floor%TYPE,
        p_section IN shelf.section%TYPE,
        p_message OUT VARCHAR2
    );

    PROCEDURE delete_shelf (
        p_id      IN shelf.id%TYPE,
        p_message OUT VARCHAR2
    );

END shelf_pkg;

/
