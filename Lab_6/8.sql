-- 8. Find how many distinct customers 
-- have at least one order supplied 
-- exclusively by suppliers from AMERICA.

SELECT count(distinct(o_custkey))
FROM customer, orders
WHERE c_custkey = o_custkey 
    AND o_orderkey not in (SELECT distinct(o_orderkey) 
                        FROM supplier, nation, region, orders, lineitem
                        WHERE r_name not in ("AMERICA") 
                        AND n_regionkey = r_regionkey 
                        AND s_nationkey = n_nationkey 
                        AND l_suppkey = s_suppkey
                        AND o_orderkey = l_orderkey);