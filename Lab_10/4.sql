CREATE TRIGGER t4 AFTER UPDATE ON orders
FOR EACH ROW
begin
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE (SELECT l_orderkey
            FROM lineitem,orders
            WHERE o_orderkey = NEW.l_orderkey);
end;

CREATE TRIGGER t4p2 AFTER DELETE ON orders
FOR EACH ROW
begin
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE (SELECT l_orderkey
            FROM lineitem,orders
            WHERE o_orderkey = OLD.l_orderkey);
end;

DELETE FROM lineitem
WHERE (SELECT l_orderkey
        FROM lineitem,orders
        WHERE l_orderkey = o_orderkey
        AND o_orderdate LIKE '%1995-12%');

SELECT COUNT(o_orderpriority)
FROM orders
WHERE o_orderdate BETWEEN '1995-12-01' AND '1995-12-31';