--======== �������� ����� ==============

--������� �1
--�������� ��� ������� ���������� ��� ����� ����������, 
--����� � ������ ����������.

select c.last_name || ' ' || c.first_name as "������� � ���", a.address as "�����", c2.city as "�����", c3.country as "������"
from customer c
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.city_id
join country c3 on c3.country_id = c2.country_id 


--������� �2
--� ������� SQL-������� ���������� ���������� ��� ����������� ��� ������� ��������.
select
    store_id as "ID ��������",
    count(customer_id) as "���������� �����������"
from
    customer
group by
   store_id;
  
  --����������� ������ � �������� ������ �� ��������, 
--� ������� ���������� ����������� ������ 300-��.
--��� ������� ����������� ���������� �� ��������������� ������� 
--� �������������� ������� ���������.
select
    store_id as "ID ��������",
    count(customer_id) as "���������� �����������"
from
    customer
group by
   store_id
having
	count(customer_id) > 300

-- ����������� ������, ������� � ���� ���������� � ������ ��������, 
--� ����� ������� � ��� ��������, ������� �������� � ���� ��������.


select s.store_id as "ID ��������", count(customer_id) as "���������� �����������", c2.city as "����� ��������", s2.last_name ||' ' || s2.first_name as "������� � ��� ��������"
from store s
join customer c on c.store_id = s.address_id
join city c2 on c2.country_id = c.store_id
join staff s2 on s2.store_id = c.store_id 
group by s.store_id, c2.city , s2.last_name ,s2.first_name 
having count(customer_id) > 300 


--������� �3
--�������� ���-5 �����������, 
--������� ����� � ������ �� �� ����� ���������� ���������� �������

select concat(c.first_name, ' ', c.last_name) as "������� � ��� ����������",
       count(distinct f.film_id) as "���������� �������"
from customer c
left join rental r on r.customer_id = c.customer_id
left join inventory i on r.inventory_id = i.inventory_id
left join film f on i.film_id = f.film_id
group by 1, c.customer_id
order by 2 
desc nulls last
limit 5;


--������� �4
--���������� ��� ������� ���������� 4 ������������� ����������:
--  1. ���������� �������, ������� �� ���� � ������
--  2. ����� ��������� �������� �� ������ ���� ������� (�������� ��������� �� ������ �����)
--  3. ����������� �������� ������� �� ������ ������
--  4. ������������ �������� ������� �� ������ ������



select concat( c.first_name, ' ',  c.last_name) as "������� � ��� ����������",
	   count( p.amount) as "���������� �������",
	   round(sum(p.amount)) as "����� ��������� ��������",
	   min(p.amount),
	   max(p.amount)
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join payment p on p.customer_id = f.film_id 
group by 1, c.customer_id, p.amount



--������� �5
--��������� ������ �� ������� ������� ��������� ����� �������� ������������ ���� ������� ����� �������,
 --����� � ���������� �� ���� ��� � ����������� ���������� �������. 
 --��� ������� ���������� ������������ ��������� ������������.

select  c.city,  c2.city 
from city c cross join city c2 
where c.city!=c2.city

--������� �6
--��������� ������ �� ������� rental � ���� ������ ������ � ������ (���� rental_date)
--� ���� �������� ������ (���� return_date), 
--��������� ��� ������� ���������� ������� ���������� ����, �� ������� ���������� ���������� ������.
 
select r.customer_id as "ID ����������", 
	   round(avg(date_part('day', r.return_date - r.rental_date))) as "������� ���������� ���� �� �������" 
from rental r 
group by 1
order by 1

