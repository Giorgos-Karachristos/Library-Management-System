--------------------------------------------------------
--  DDL for Function GET_LIBRARIANS_EXCEPT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_LIBRARIANS_EXCEPT" (
    p_id IN librarian.id%TYPE
) RETURN librarian_table
    PIPELINED
IS
BEGIN
    FOR c IN (
        SELECT
            librarian_obj(id, username, first_name, last_name, email,
                          is_active) librarian
        FROM
            librarian
        WHERE
            id != p_id
    ) LOOP
        PIPE ROW ( c.librarian );
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Function IS_IT_VALID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_IT_VALID" (
    source_string IN VARCHAR2,
    regular_expression IN VARCHAR2
) RETURN BOOLEAN AS
BEGIN
    RETURN REGEXP_LIKE(source_string , regular_expression);
END is_it_valid;

/
--------------------------------------------------------
--  DDL for Function LOGIN_LIBRARIAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "LOGIN_LIBRARIAN" (
    p_username      IN librarian.username%TYPE,
    p_password_hash IN librarian.password_hash%TYPE
) RETURN login_result_obj IS
    
    v_nor_username librarian.username%TYPE;
    v_id         librarian.id%TYPE;
    v_username   librarian.username%TYPE;
    v_first_name librarian.first_name%TYPE;
    v_last_name  librarian.last_name%TYPE;
    v_email      librarian.email%TYPE;
    v_message    VARCHAR2(200);
BEGIN
    v_nor_username := lower(trim(p_username));
    IF v_nor_username IS NULL THEN
        RETURN login_result_obj(NULL, NULL, NULL, NULL, NULL,
                               'Username is required.');
    END IF;

    IF p_password_hash IS NULL THEN
        RETURN login_result_obj(NULL, NULL, NULL, NULL, NULL,
                               'Password hash is required.');
    END IF;

    SELECT
        id,
        username,
        first_name,
        last_name,
        email
    INTO
        v_id,
        v_username,
        v_first_name,
        v_last_name,
        v_email
    FROM
        librarian
    WHERE
            is_active = 'Y'
        AND username = v_nor_username
        AND password_hash = p_password_hash;

    RETURN login_result_obj(v_id, v_username, v_first_name, v_last_name, v_email,
                           'Login successful.');
EXCEPTION
    WHEN no_data_found THEN
        RETURN login_result_obj(NULL, NULL, NULL, NULL, NULL,
                               'Invalid username or password.');
END;

/
