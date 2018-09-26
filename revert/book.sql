-- Revert veorfolnir:book from mysql

BEGIN;

drop table IF EXISTS book;

COMMIT;
