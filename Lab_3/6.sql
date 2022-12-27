SELECT DISTINCT n_name 
FROM nation, orders, customer
WHERE o_orderdate >= '1994-09-09' AND 
    o_orderdate <= '1994-09-11' AND
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey
ORDER BY n_name ASC