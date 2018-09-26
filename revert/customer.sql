-- Revert veorfolnir:customer from mysql

BEGIN;

drop table IF EXISTS customer;

COMMIT;
