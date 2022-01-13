--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите уникальные названия регионов из таблицы адрес

select distinct district 
from address

--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те регионы, 
--названия которых начинаются на "K" и заканчиваются на "a", и названия не содержат пробелов
select distinct district 
from address 
where district like 'K%a' and district not like '% %'

--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись 
--в промежуток с 17 марта 2007 года по 19 марта 2007 года включительно, 
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.
select payment_id, payment_date, amount 
from payment p 
where payment_date >= '2007.03.17' and payment_date <= '2007.03.20' and amount > 1.00
order by payment_date 

--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.

select payment_id, payment_date, amount 
from payment p 
order by payment_date  desc
limit 10

--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.

select last_name || ' ' || first_name as "Фамилия и Имя", email as "Электронная почта", character_length(email) as "Длина Email", date(last_update) as "Дата" 
from customer c


--ЗАДАНИЕ №6
--Выведите одним запросом активных покупателей, имена которых Kelly или Willie.
--Все буквы в фамилии и имени из нижнего регистра должны быть переведены в высокий регистр.

select upper(last_name::text) as "last_name", upper(first_name::text) as "first_name"
from customer c
where first_name ilike 'Kelly' or first_name ilike 'Willie'
