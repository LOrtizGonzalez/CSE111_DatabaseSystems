-- Find the number of customers who had at 
-- least three orders in November 1995 (o orderdate).

SELECT count(C1.c_custkey)
FROM customer C1,
    (SELECT c_custkey, count(o_orderdate) amount
    FROM customer , orders
    WHERE c_custkey = o_custkey
        AND o_orderdate LIKE '1995-11-%'
    GROUP BY c_custkey
    ) P1
WHERE P1.amount >= 3
    AND C1.c_custkey = P1.c_custkey
