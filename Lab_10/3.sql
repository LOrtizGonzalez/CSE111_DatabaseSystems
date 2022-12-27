CREATE TRIGGER t3 AFTER UPDATE ON customer
FOR EACH ROW
begin
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE c_acctbal > 0;
end;

UPDATE customer
SET c_acctbal = 100--'100000'
WHERE c_nationkey = 24;

SELECT COUNT(c_custkey)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey
AND n_regionkey = r_regionkey
AND r_name = 'AMERICA'
AND c_acctbal < 0;