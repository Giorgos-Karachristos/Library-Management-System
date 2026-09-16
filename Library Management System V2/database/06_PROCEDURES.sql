--------------------------------------------------------
--  DDL for Procedure EXPIRE_RESERVATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "EXPIRE_RESERVATIONS" AS
BEGIN
    UPDATE reservation
    SET
        status = 'Expired'
    WHERE
            status = 'Ready'
        AND ready_date + 3 <= sysdate;

END expire_reservations;

/
