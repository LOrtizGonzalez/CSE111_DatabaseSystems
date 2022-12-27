-- 9. Find the distinct parts (p name) ordered 
-- by customers from AMERICA that are supplied 
-- by exactly 3 suppliers from ASIA.

SELECT DISTINCT(p_name)
FROM part, customer, orders, lineitem, nation, region
WHERE r_name = "AMERICA" 
    AND r_regionkey = n_regionkey 
    AND n_nationkey = c_nationkey
    AND o_custkey = c_custkey 
    AND l_orderkey = o_orderkey 
    AND p_partkey = l_partkey
    AND p_name in (SELECT distinct(p_name) 
                    FROM part, lineitem, nation, region, supplier
                    WHERE r_name = "ASIA"  
                    AND r_regionkey = n_regionkey 
                    AND n_nationkey = s_nationkey
                    AND  l_suppkey = s_suppkey 
                    AND p_partkey = l_partkey
 Group by p_name
 Having Count(s_suppkey) == 3)
 Order by p_name ASC;


-- SELECT DISTINCT p_name
-- FROM part, customer, nation, region, orders, lineitem
-- WHERE p_partkey = l_partkey
--     AND l_orderkey = o_orderkey
--     AND o_custkey = c_custkey
--     AND c_nationkey = n_nationkey
--     AND n_regionkey = r_regionkey
--     AND r_name = "AMERICA"