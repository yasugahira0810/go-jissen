drop database gwp;
create database gwp;
drop user gwp;
create user gwp with password 'gwp';
grant all privileges on database gwp to gwp;

drop table posts;

create table posts (
  id      serial primary key,
  content text,
  author  varchar(255)
);
