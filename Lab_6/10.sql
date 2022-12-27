SELECT r_name
FROM region, nation, customer, lineitem, orders, supplier
WHERE n_regionkey = r_regionkey 
    AND s_nationkey = n_nationkey 
    AND c_nationkey = n_nationkey
    AND l_suppkey = s_suppkey 
    AND o_orderkey = l_orderkey 
    AND c_custkey = o_custkey
Group by r_name
Order by SUM(l_extendedprice) ASC
LIMIT 1;