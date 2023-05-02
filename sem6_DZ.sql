use lesson_5;
/* Задача 1
Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

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
    DECLARE result VARCHAR(45) DEFAULT '2';
	WHILE b-1 > a DO    
		SET num = num1 +  2;
		SET num1 = num;		
		SET b = b-2;
		SET result = CONCAT(result, ' ', num);
    END WHILE;
    RETURN result;    
    END //
    delimiter ;
    
select task6_2(1,10);