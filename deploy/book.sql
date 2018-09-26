-- Deploy veorfolnir:book to mysql

BEGIN;

      create table IF NOT EXISTS book (
       id bigint not null,
        __isset_bitfield tinyint not null,
        author varchar(255),
        edition bigint not null,
        format varchar(255),
        isbn10 varchar(255),
        isbn13 varchar(255),
        language varchar(255),
        pages bigint not null,
        publish_date bigint not null,
        title varchar(255),
        primary key (id)
    );

COMMIT;
