use lesson_5;
/* Задача 1
Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
/* drop FUNCTION sectotime;
delimiter //
CREATE FUNCTION sectotime(val INT)
-- RETURNS char(15)
returns varchar(30)
DETERMINISTIC
begin
	declare DD char(3);
	declare HH, MI, SS char(2);
	declare res char(15);
	set DD = cast(floor(val/60/60/24) as char(3));
	set HH = cast(floor(mod(val/60/60/24,1)*24) as char(2));
	set MI = cast(floor(mod(mod(val/60/60/24,1)*24,1)*60) as char(2));
	set SS = cast(round(mod(mod(mod(val/60/60/24,1)*24,1)*60,1)*60) as char(2));
	set res = concat(DD,'d',HH,'h',MI,'m',SS,'s');
	return res;
end //
delimiter ;
select sectotime(123456);*/
-- SELECT SEC_TO_TIME(123456);

drop FUNCTION task6_1;
delimiter //
CREATE FUNCTION task6_1(seconds INT)
-- RETURNS char(15)
returns varchar(30)
DETERMINISTIC
begin
	declare D CHAR(3);
	declare H, M, S CHAR(2);
	declare res char(50);
    declare Ds, Hs, Ms int;    
    set D=floor(seconds/(60*60*24));   
    set Ds=mod(seconds,86400);     
    set H=floor(Ds/3600);   
    set Hs=mod(Ds, 3600);
    set M=floor(Hs/60);
    set S=mod(Hs, 60);      
    set res=concat(D,' day ',H,' hours ',M, ' min ', S,' sec');
   
	return res;
end //
delimiter ;

select task6_1(123456);

/* Задача 2.
Выведите только четные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

drop function task6_2;
delimiter //
CREATE FUNCTION task6_2(a INT, b int)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
	DECLARE num1 INT DEFAULT 2;
    DECLARE num INT DEFAULT 0;
    DECLARE result VARCHAR(45) DEFAULT '2'; -- Первые числа Фибоначчи*/
	WHILE b-1 > a DO    
		SET num = num1 +  2;
		SET num1 = num;
		-- SET fib2 = fib3;
		SET b = b-2;
		SET result = CONCAT(result, ' ', num);
    END WHILE;
    RETURN result;    
    END //
    delimiter ;
    
select task6_2(1,10);
/*
drop function task1;
DELIMITER //
create function task1(a int, b int)
returns int
deterministic
begin	
	DECLARE a INT DEFAULT 0;
   DECLARE result VARCHAR(45) DEFAULT '2';
   
    while a<=b do
		begin
			if MOD(a, 2) = 0 then			
				SET result = CONCAT(result, ' ', a);		   
           set a = a+1;
           end if;				            
		end;
	END WHILE;
    return result;
end //    
delimiter ;
    
select task1(1, 10);*/