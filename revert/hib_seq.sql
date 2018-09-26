-- Revert veorfolnir:hib_seq from mysql

BEGIN;

drop table IF EXISTS hibernate_sequence;

COMMIT;
