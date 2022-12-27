CREATE TRIGGER t2 AFTER UPDATE ON orders
FOR EACH ROW
begin
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE c_acctbal < 0;
end;

UPDATE customer
SET c_acctbal = '-100'
WHERE (SELECT c_custkey
        FROM customer,nation,region
        WHERE c_nationkey = n_nationkey
        AND n_regionkey = 1);

SELECT COUNT(c_custkey)
FROM customer,nation
WHERE c_nationkey = n_nationkey
AND n_name = 'CANADA'
AND c_acctbal < 0;