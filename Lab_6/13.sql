SELECT n_name
FROM nation, supplier, lineitem
WHERE s_nationkey = n_nationkey 
    AND l_suppkey = s_suppkey
    AND l_shipdate like "1994-%-%"
Group by n_name
Order by SUM(l_extendedprice) DESC
LIMIT 1;