CREATE TRIGGER t1 BEFORE INSERT ON orders
FOR EACH ROW
begin
    UPDATE orders
    SET o_orderdate = DATE('2021-12-01')
    WHERE o_orderkey = NEW.o_orderkey;
end;

INSERT INTO orders
SELECT *
FROM orders
WHERE o_orderdate BETWEEN '1996-12-01' AND '1996-12-31';

SELECT COUNT(o_orderkey)
FROM orders
WHERE o_orderdate LIKE '%2021%';