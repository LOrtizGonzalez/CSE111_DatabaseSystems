-- 5. Find how many suppliers supply 
-- the most expensive part (p retailprice).

SELECT count( s_suppkey )
FROM supplier, part, partsupp, 
    (SELECT MAX(p_retailprice) most
    FROM part
    )
WHERE s_suppkey = ps_suppkey
    AND ps_partkey = p_partkey
    AND p_retailprice = most