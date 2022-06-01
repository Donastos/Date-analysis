--=============== МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--1 Пронумеруйте все платежи от 1 до N по дате

--2 Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате

--3 Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна 
--быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей

select customer_id,  payment_date, amount,
	sum(amount) over (partition by customer_id order by payment_date, sum(amount) asc)
from payment p
group by customer_id, payment_date, amount

--4 Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим 
--так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
-- Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.

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

--ЗАДАНИЕ №2
--С помощью оконной функции выведите для каждого покупателя стоимость платежа и стоимость 
--платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.

select 
	customer_id, 
	row_number() over (partition by customer_id order by payment_date desc) as "payment_id",
	payment_date ,
	amount,
	lag(amount, 1, 0.0) over (partition by customer_id order by payment_date desc) as "last_amount"	
from payment p
group by customer_id,payment_date, amount

--ЗАДАНИЕ №3
--С помощью оконной функции определите, на сколько каждый следующий платеж покупателя больше или меньше текущего.


--если правильно понял задание, то его структура такая:
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

--ЗАДАНИЕ №4
--С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.

select 
	row_number ()  over(partition by customer_id order by payment_id),
	pa
	payment_date ,
	amount
from payment p
group by customer_id,payment_date, amount, payment_id
order by customer_id



