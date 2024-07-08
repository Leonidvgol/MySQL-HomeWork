/* 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds ' */

DROP FUNCTION IF EXISTS times;
DELIMITER $$ -- //
CREATE FUNCTION times(sec INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE days INT; -- 365
	DECLARE hours INT; -- 24
	DECLARE minutes INT; -- 60
	DECLARE seconds INT; -- 60
	DECLARE res VARCHAR(255);
	SET days = FLOOR(sec/60/60/24);
	SET hours = FLOOR(sec/60/60%24);
	SET minutes = FLOOR(sec/60%60);
	SET seconds = FLOOR(sec%60);
	SET res = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds ');
    RETURN res;
END $$ -- //
DELIMITER ;

SELECT times(123456);

/* 2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10 */

DROP PROCEDURE IF EXISTS even_number;

DELIMITER $$ -- //
CREATE PROCEDURE even_number(num INT)
BEGIN
    DECLARE x INT DEFAULT 2;
    DECLARE res VARCHAR(255) default x;
    CASE
		WHEN num = 1 
			THEN SET res = 'Четных чисел нет';
		WHEN num BETWEEN 2 AND 3 
			THEN SET res = 2;
		WHEN num > 3
			THEN REPEAT
        SET x = x + 2;
		SET res = CONCAT(res, ',', x);
		UNTIL x >= num - 1
		END REPEAT;
		ELSE SET res = 'Некорректные данные';
	END CASE;
    SELECT res;
END $$ -- //
DELIMITER ;
CALL even_number(10)

