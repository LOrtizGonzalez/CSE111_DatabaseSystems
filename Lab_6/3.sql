-- Find how many parts are supplied by 
-- exactly two suppliers from UNITED STATES.

SELECT count(p1.p_partkey)
FROM part p1, 
    (SELECT p_partkey, count(s_suppkey) US_suppliers
    FROM part, partsupp, supplier, nation
    WHERE p_partkey = ps_partkey
        AND ps_suppkey = s_suppkey
        AND s_nationkey = n_nationkey
        AND n_name = "UNITED STATES"
    GROUP BY p_partkey
    ) P
WHERE P.US_suppliers = 2
    AND p1.p_partkey = P.p_partkey