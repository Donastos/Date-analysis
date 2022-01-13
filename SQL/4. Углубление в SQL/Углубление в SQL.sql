--=============== ������ 4. ���������� � SQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;
--======== �������� ����� ==============

--������� �1

--���� ������: ���� ����������� � �������� ����, 
--�� ������� ����� ����� � ��������� � 
--���� �������, �������� ������ ���� �� �������� � ������ �������� � ������� �������� 
--� ���� ����� �����, ���� ����������� � ���������� �������, �� ������� ����� ����� � 
--� ��� ������� �������.

--������������� ���� ������, ���������� ��� �����������:
--� ���� (����������, ����������� � �. �.);
--� ���������� (�������, ���������� � �. �.);
--� ������ (������, �������� � �. �.).
--��� ������� �� �������, ��������� ������ �� ������. ������ ������� �� ������� � film_actor.
--���������� � ��������-������������:
--� ������� ����������� ��������� ������.
--� �������������� �������� ������ ������������� ���������������;
--� ������������ ��������� �� ������ ��������� null-��������, �� ������ ����������� --��������� � ��������� ���������.
--���������� � �������� �� �������:
--� ������� ����������� ��������� � ������� ������.
--� �������� ������ �� ������� �������� ������� �������� ������ � ������� �� --���������� � ������ ������� �� 5 ����� � �������.
 

CREATE SCHEMA schema_fatykhov

--�������� ������� �����

create table languages(
 language_id SERIAL primary key,
 language_name varchar(50) unique not null
 );

--�������� ������ � ������� �����

insert into languages(language_name)
values('english'), ('french'), ('german'), ('tatar');

--select * from languages l


--�������� ������� ����������

create table nationalities(
 nationalitie_id SERIAL primary key,
 nationalitie_name varchar(50) unique not null
 );


--�������� ������ � ������� ����������

insert into nationalities(nationalitie_name)
values('slavs'), ('anglo-saxons'), ('tatars'), ('celts');

--select * from nationalities n


--�������� ������� ������
drop table countries cascade

create table countries(
 countries_id SERIAL primary key,
 countries_name varchar(50) unique not null
 );


--�������� ������ � ������� ������

insert into countries(countries_name)
values('russia'), ('germany'), ('france'), ('greece');

--select * from countries c

--�������� ������ ������� �� �������
--drop table countries_nationalities
create table countries_nationalities(
	countries_id int4 not null references countries(countries_id),
	nationalitie_id int4 not null references nationalities(nationalitie_id),
	primary key (countries_id,nationalitie_id)
);

--�������� ������ � ������ ������� �� �������

insert into countries_nationalities
values(1,1),(1,3),(2,2),(4,4)
--select * from countries_nationalities 


--�������� ������ ������� �� �������
--drop table languages_nationalities
create table languages_nationalities(
	language_id int4 not null references languages(language_id),
	nationalitie_id int4 not null references nationalities(nationalitie_id),
	primary key (language_id,nationalitie_id)
);

--�������� ������ �� ������ ������� �� �������
insert into languages_nationalities
values(1,1),(2,2),(3,2),(4,3)
--select * from languages_nationalities 
