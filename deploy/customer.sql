-- Deploy veorfolnir:customer to mysql

BEGIN;

      create table IF NOT EXISTS customer (
       id bigint not null,
        first_name varchar(255),
        last_name varchar(255),
        primary key (id)
    );

COMMIT;
