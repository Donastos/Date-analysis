--======== �������� ����� ==============

--������� �1
--�������� ���������� �������� �������� �� ������� �����

select distinct district 
from address

--������� �2
--����������� ������ �� ����������� �������, ����� ������ ������� ������ �� �������, 
--�������� ������� ���������� �� "K" � ������������� �� "a", � �������� �� �������� ��������
select distinct district 
from address 
where district like 'K%a' and district not like '% %'

--������� �3
--�������� �� ������� �������� �� ������ ������� ���������� �� ��������, ������� ����������� 
--� ���������� � 17 ����� 2007 ���� �� 19 ����� 2007 ���� ������������, 
--� ��������� ������� ��������� 1.00.
--������� ����� ������������� �� ���� �������.
select payment_id, payment_date, amount 
from payment p 
where payment_date >= '2007.03.17' and payment_date <= '2007.03.20' and amount > 1.00
order by payment_date 

--������� �4
-- �������� ���������� � 10-�� ��������� �������� �� ������ �������.

select payment_id, payment_date, amount 
from payment p 
order by payment_date  desc
limit 10

--������� �5
--�������� ��������� ���������� �� �����������:
--  1. ������� � ��� (� ����� ������� ����� ������)
--  2. ����������� �����
--  3. ����� �������� ���� email
--  4. ���� ���������� ���������� ������ � ���������� (��� �������)
--������ ������� ������� ������������ �� ������� �����.

select last_name || ' ' || first_name as "������� � ���", email as "����������� �����", character_length(email) as "����� Email", date(last_update) as "����" 
from customer c


--������� �6
--�������� ����� �������� �������� �����������, ����� ������� Kelly ��� Willie.
--��� ����� � ������� � ����� �� ������� �������� ������ ���� ���������� � ������� �������.

select upper(last_name::text) as "last_name", upper(first_name::text) as "first_name"
from customer c
where first_name ilike 'Kelly' or first_name ilike 'Willie'
