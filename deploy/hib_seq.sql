-- Deploy veorfolnir:hib_seq to mysql

BEGIN;

     create table IF NOT EXISTS hibernate_sequence (
       next_val bigint
    );
    
    insert into hibernate_sequence (next_val) values (0);

COMMIT;
