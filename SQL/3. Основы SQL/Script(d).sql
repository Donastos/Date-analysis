--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.

select c.last_name || ' ' || c.first_name as "Фамилия и Имя", a.address as "Адрес", c2.city as "Город", c3.country as "Страна"
from customer c
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.city_id
join country c3 on c3.country_id = c2.country_id 


--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте количество его покупателей для каждого магазина.
select
    store_id as "ID магазина",
    count(customer_id) as "Количество покупателей"
from
    customer
group by
   store_id;
  
  --Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.
select
    store_id as "ID магазина",
    count(customer_id) as "Количество покупателей"
from
    customer
group by
   store_id
having
	count(customer_id) > 300

-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.


select s.store_id as "ID магазина", count(customer_id) as "Количество покупателей", c2.city as "Город Магазина", s2.last_name ||' ' || s2.first_name as "Фамилия и имя продавца"
from store s
join customer c on c.store_id = s.address_id
join city c2 on c2.country_id = c.store_id
join staff s2 on s2.store_id = c.store_id 
group by s.store_id, c2.city , s2.last_name ,s2.first_name 
having count(customer_id) > 300 


--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

select concat(c.first_name, ' ', c.last_name) as "Фамилия и имя покупателя",
       count(distinct f.film_id) as "Количество фильмов"
from customer c
left join rental r on r.customer_id = c.customer_id
left join inventory i on r.inventory_id = i.inventory_id
left join film f on i.film_id = f.film_id
group by 1, c.customer_id
order by 2 
desc nulls last
limit 5;


--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма



select concat( c.first_name, ' ',  c.last_name) as "Фамилия и имя покупателя",
	   count( p.amount) as "Количество фильмов",
	   round(sum(p.amount)) as "Общая стоимость платежей",
	   min(p.amount),
	   max(p.amount)
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join payment p on p.customer_id = f.film_id 
group by 1, c.customer_id, p.amount



--ЗАДАНИЕ №5
--Используя данные из таблицы городов составьте одним запросом всевозможные пары городов таким образом,
 --чтобы в результате не было пар с одинаковыми названиями городов. 
 --Для решения необходимо использовать декартово произведение.

select  c.city,  c2.city 
from city c cross join city c2 
where c.city!=c2.city

--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date)
--и дате возврата фильма (поле return_date), 
--вычислите для каждого покупателя среднее количество дней, за которые покупатель возвращает фильмы.
 
select r.customer_id as "ID покупателя", 
	   round(avg(date_part('day', r.return_date - r.rental_date))) as "Среднее количество дней на возврат" 
from rental r 
group by 1
order by 1

