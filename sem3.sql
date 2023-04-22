drop database if exists lesson3;
create database if not exists lesson3;

use lesson3;

# '' "" ``
drop table if exists staff;
create table if not exists `staff`
(
`id` int primary key auto_increment,
`firstname` VARCHAR(45),
`lastname` VARCHAR(45),
`post` VARCHAR(45),
`seniority` INT,
`salary` INT,
`age` INT
);

alter table staff
modify post varchar(30);

INSERT INTO `staff` (`firstname`, `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
('Вася', 'Васькин', 'Начальник', 40, 100000, 60),
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

DROP TABLE IF EXISTS activity_staff;
CREATE TABLE IF NOT EXISTS `activity_staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`staff_id` INT,
FOREIGN KEY(staff_id) REFERENCES staff(id),
`date_activity` DATE,
`count_pages` INT
);

INSERT `activity_staff` (`staff_id`, `date_activity`, `count_pages`)
VALUES
(1,'2022-01-01',250),
(2,'2022-01-01',220),
(3,'2022-01-01',170),
(1,'2022-01-02',100),
(2,'2022-01-01',220),
(3,'2022-01-01',300),
(7,'2022-01-01',350),
(1,'2022-01-03',168),
(2,'2022-01-03',62),
(3,'2022-01-03',84);

-- средняя зарплата работников
select *
from staff;

select avg(salary)
from staff;

select *
from staff
where salary >(select avg(salary) from staff);

select salary, id
from staff
order by salary desc; -- asc от меньшего к большему, desc от большего к меньшему

select *
from staff
where seniority >5 and post = 'Рабочий'
order by salary;

-- Выведите все записи, отсортированные по полю "age" по возростанию
select *
from staff
order by age asc;

-- Выведите все записи, отсортированные по полю "firstname" 
select  *
from staff
order by firstname asc;

-- Выведите записи полей "firstname", "lastname","age", отсортированные по полю "firstname"
-- в алфавитном порядке по убыванию
select id, firstname, lastname, age
from staff
order by firstname desc;

-- выполните сортировку по полям "firstname" и "age" по убыванию
select id, firstname, age
from staff
order by firstname desc, age desc;

select id, firstname, age
from staff
limit 5;

-- при выводе 2 и 3 строчки пропустить
select id, firstname, age
from staff
limit 2,3; -- первая строка отвечает за кол-во пропущенных строк, вторая за кол-во выводимых строк

-- вывод уникальных фамилий
-- select count(distinct lastname) - выводит кол-во
select distinct lastname   -- выводит список
from staff;

-- вывод неуникальных фамилий
select count(lastname)-count(distinct lastname) as 'число'
from staff;

-- 1. Выведите уникальные (неповторяющиеся) значения полей "firstname"
-- select count(distinct firstname) 
select distinct firstname   -- выводит список
from staff;

-- 2. Отсортируйте записи по возрастанию значений поля "id". Выведите первые две записи данной выборки
select *
from staff
order by id desc
limit 0,2;

-- 3. Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки 
-- данной выборки и извлеките следующие 3
select *
from staff
order by id desc
limit 4,3;

-- 4. Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и 
-- извлеките следующие за ними 3 строки
select *
from staff
order by id asc
limit 2,3;

select * from staff;

-- Группировка 
-- по должности
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- SET GLOBAl sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- SELECT COUNT(salary), COUNT(lastname), COUNT(post),
SELECT count(salary), lastname, post,
MAX(salary) AS "Макс зарплата",
MIN(salary) AS "Минзарплата",
MAX(salary) - MIN(salary) AS "Разница"
FROM staff
GROUP BY post;

-- 1.Выведите общее количество напечатанных страниц каждым сотрудником
SELECT staff_id, sum(count_pages) as "общее кол-во"
from activity_staff
group by staff_id;

-- 2. Посчитайте количество страниц за каждый день
SELECT staff_id, sum(count_pages) as "общее кол-во"
from activity_staff
group by date_activity;

-- 3. Найдите среднее арифметическое по количеству ежедневных страниц
select avg(count_pages) as "среднее"
from activity_staff
group by date_activity;

/* 
/*Сгруппируйте данные о сотрудниках по возрасту: 
1 группа – младше 20 лет
2 группа – от 20 до 40 лет
3 группа – старше  40 лет 
Для каждой группы  найдите суммарную зарплату */

SELECT sum(salary), name_age
FROM 
(select salary,
case
when age < 20 then "Младше 20"
when age between 20 and 40 then "от 20 до 40"
else "больше 40"
end as name_age
from staff) as lists
group by name_age;

-- оператор having
-- Сгруппировать сотрудников у кого зарплата больше 50тр
select count(salary), count(firstname), GROUP_CONCAT(firstname)
from staff
group by salary
having salary > 50000;

select *
from staff
-- having salary >50000;
where salary >50000;

select post, avg(salary)
from staff
where post !="Инженер"
group by post
having avg(salary) > 50000;

-- ДОМАШНЕЕ ЗАДАНИЕ
-- 1. Выведите id сотрудников, которые напечатали более 500 страниц за всех дни
SELECT staff_id
from activity_staff
group by staff_id
having sum(count_pages) > 500;

-- 2.  Выведите  дни, когда работало более 3 сотрудников. 
-- Также укажите кол-во сотрудников, которые работали в выбранные дни.
SELECT date_activity as "Дни", 
		count(distinct staff_id) as "Кол-во сотрудников", 
		GROUP_CONCAT(distinct staff_id) as "Кто работал"
from activity_staff
group by date_activity
having count(id)>3;

-- 3. Выведите среднюю заработную плату по должностям, которая составляет более 30000 
SELECT post as "Должность", avg(salary) AS "Средняя зарплата"
FROM staff
GROUP BY post
having avg(salary)>30000;

-- 4. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания 
select *
from staff
order by salary asc;

select *
from staff
order by salary desc;

-- 5. Выведите 5 максимальных заработных плат (salary)
select *
from staff
order by salary desc
limit 5;

-- 6. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
select post as "Специальность", sum(salary) as "Суммарная зарплата"
from staff
group by post;

-- 7. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
select count(post) as "кол-во сотрудников «Рабочий»", GROUP_CONCAT(firstname," " ,lastname) as "Кто работал"
from staff
where age >=24 and age <=49 and post = 'Рабочий'
order by count(post);

-- 8. Найдите количество специальностей
select count(distinct post) as "Количество специальностей"
from staff;

-- 9. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет 
select post as "Специальность", round(avg(age),1) as "Средний возраст"
from staff
group by post
having avg(age)< 30;
