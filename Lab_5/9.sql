-- Print the name of the parts supplied 
-- by suppliers from UNITED STATES that have 
-- total value in the top 1% total values 
-- across all the supplied parts. The total 
-- value is ps supplycost*ps availqty. Hint:
-- Use the LIMIT keyword.

SELECT p_name
FROM supplier, part, nation, partsupp, lineitem
WHERE n_name = "UNITED STATES" 
    AND s_nationkey == n_nationkey 
    AND ps_suppkey = s_suppkey
    AND p_partkey = ps_partkey 
    AND (ps_supplycost * ps_availqty)
    IN (SELECT ps_supplycost * ps_availqty  
        FROM partsupp
        ORDER BY ps_supplycost * ps_availqty DESC LIMIT (SELECT count(*) * 0.01 FROM partsupp))
group by p_name;