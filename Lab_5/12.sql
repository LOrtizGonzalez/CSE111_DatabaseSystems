-- What is the total supply cost 
-- (ps supplycost) for parts less expensive 
-- than $1000 (p retailprice) shipped in 
-- 1997 (l shipdate) by suppliers who did not 
-- supply any line item with an extended price 
-- less than 2000 in 1996?

SELECT sum(ps_supplycost)
FROM partsupp, part, lineitem
WHERE p_partkey = ps_partkey 
    AND l_partkey = ps_partkey 
    AND p_retailprice < 1000
    AND l_shipdate like "1997-%-%" 
    AND ps_suppkey not in (SELECT l_suppkey 
                            FROM lineitem
                            WHERE l_extendedprice < 2000 
                            AND l_shipdate like "1996-%-%")

