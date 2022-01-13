--=============== МОДУЛЬ 4. УГЛУБЛЕНИЕ В SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;
--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1

--База данных: если подключение к облачной базе, 
--то создаёте новую схему с префиксом в 
--виде фамилии, название должно быть на латинице в нижнем регистре и таблицы создаете 
--в этой новой схеме, если подключение к локальному серверу, то создаёте новую схему и 
--в ней создаёте таблицы.

--Спроектируйте базу данных, содержащую три справочника:
--· язык (английский, французский и т. п.);
--· народность (славяне, англосаксы и т. п.);
--· страны (Россия, Германия и т. п.).
--Две таблицы со связями, отношения многие ко многим. Пример таблицы со связями — film_actor.
--Требования к таблицам-справочникам:
--· наличие ограничений первичных ключей.
--· идентификатору сущности должен присваиваться автоинкрементом;
--· наименования сущностей не должны содержать null-значения, не должны допускаться --дубликаты в названиях сущностей.
--Требования к таблицам со связями:
--· наличие ограничений первичных и внешних ключей.
--В качестве ответа на задание пришлите запросы создания таблиц и запросы по --добавлению в каждую таблицу по 5 строк с данными.
 

CREATE SCHEMA schema_fatykhov

--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ

create table languages(
 language_id SERIAL primary key,
 language_name varchar(50) unique not null
 );

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ ЯЗЫКИ

insert into languages(language_name)
values('english'), ('french'), ('german'), ('tatar');

--select * from languages l


--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ

create table nationalities(
 nationalitie_id SERIAL primary key,
 nationalitie_name varchar(50) unique not null
 );


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ НАРОДНОСТИ

insert into nationalities(nationalitie_name)
values('slavs'), ('anglo-saxons'), ('tatars'), ('celts');

--select * from nationalities n


--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ
drop table countries cascade

create table countries(
 countries_id SERIAL primary key,
 countries_name varchar(50) unique not null
 );


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СТРАНЫ

insert into countries(countries_name)
values('russia'), ('germany'), ('france'), ('greece');

--select * from countries c

--СОЗДАНИЕ ПЕРВОЙ ТАБЛИЦЫ СО СВЯЗЯМИ
--drop table countries_nationalities
create table countries_nationalities(
	countries_id int4 not null references countries(countries_id),
	nationalitie_id int4 not null references nationalities(nationalitie_id),
	primary key (countries_id,nationalitie_id)
);

--ВНЕСЕНИЕ ДАННЫХ В ПЕРВУЮ ТАБЛИЦУ СО СВЯЗЯМИ

insert into countries_nationalities
values(1,1),(1,3),(2,2),(4,4)
--select * from countries_nationalities 


--СОЗДАНИЕ ВТОРОЙ ТАБЛИЦЫ СО СВЯЗЯМИ
--drop table languages_nationalities
create table languages_nationalities(
	language_id int4 not null references languages(language_id),
	nationalitie_id int4 not null references nationalities(nationalitie_id),
	primary key (language_id,nationalitie_id)
);

--ВНЕСЕНИЕ ДАННЫХ ВО ВТОРУЮ ТАБЛИЦУ СО СВЯЗЯМИ
insert into languages_nationalities
values(1,1),(2,2),(3,2),(4,3)
--select * from languages_nationalities 
