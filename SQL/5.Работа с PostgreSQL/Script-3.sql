--=============== ������ 5. ������ � POSTGRESQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� ������ � ������� payment � � ������� ������� ������� �������� ����������� ������� �������� ��������:
--1 ������������ ��� ������� �� 1 �� N �� ����

--2 ������������ ������� ��� ������� ����������, ���������� �������� ������ ���� �� ����

--3 ���������� ����������� ������ ����� ���� �������� ��� ������� ����������, ���������� ������ 
--���� ������ �� ���� �������, � ����� �� ����� ������� �� ���������� � �������
select customer_id,  payment_date, amount,
	sum(amount) over (partition by customer_id order by payment_date, sum(amount) asc)
from payment p
group by customer_id, payment_date, amount

--4 ������������ ������� ��� ������� ���������� �� ��������� ������� �� ���������� � ������� 
--���, ����� ������� � ���������� ��������� ����� ���������� �������� ������.
-- ����� ��������� �� ������ ����� ��������� SQL-������, � ����� ���������� ��� ������� � ����� �������.

select 
	customer_id, 
	payment_id,
	payment_date,
	sum(amount) over (partition by customer_id order by payment_date desc)
from payment p 
order by customer_id,payment_id

select 
	customer_id,
	row_number() over (partition by amount order by payment_date)
from payment p 
order by p.customer_id 

select 
	customer_id,
	row_number() over (partition by payment_id order by payment_date)
from payment p 
order by customer_id 


--������� �2
--� ������� ������� ������� �������� ��� ������� ���������� ��������� ������� � ��������� 
--������� �� ���������� ������ �� ��������� �� ��������� 0.0 � ����������� �� ����.

select 
	customer_id, 
	row_number() over (partition by customer_id order by payment_date desc) as "payment_id",
	payment_date ,
	amount,
	lag(amount, 1, 0.0) over (partition by customer_id order by payment_date desc) as "last_amount"	
from payment p
group by customer_id,payment_date, amount

--������� �3
--� ������� ������� ������� ����������, �� ������� ������ ��������� ������ ���������� ������ ��� ������ ��������.


--���� ��������� ����� �������, �� ��� ��������� �����:
--lag(amount)<=amount<=lead(amount)
--amount-lag(amount)

select customer_id, 
	row_number() over (partition by customer_id order by payment_date desc) as "payment_id",
	payment_date,
	amount,
	case
		when amount >= lag(amount) over (partition by customer_id order by payment_id)
			then amount - lag(amount) over (partition by customer_id order by payment_id)
		when amount <= lead(amount) over (partition by customer_id order by payment_id)  
			then amount - lead(amount) over (partition by customer_id order by payment_id)  
		else amount
	end as "difference"
from payment
order by customer_id, payment_id 
--������� �4
--� ������� ������� ������� ��� ������� ���������� �������� ������ � ��� ��������� ������ ������.

select 
	row_number ()  over(partition by customer_id order by payment_id),
	pa
	payment_date ,
	amount
from payment p
group by customer_id,payment_date, amount, payment_id
order by customer_id



