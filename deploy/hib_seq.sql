-- Deploy veorfolnir:hib_seq to mysql

BEGIN;

     create table IF NOT EXISTS hibernate_sequence (
       next_val bigint(20)
    );
    
    insert into hibernate_sequence (next_val) values (0);
    insert into hibernate_sequence (next_val) values (1);

COMMIT;
