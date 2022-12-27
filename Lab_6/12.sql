SELECT n_name
FROM nation, customer, orders, 
    (SELECT count(o_totalprice) as T 
    FROM orders, nation, customer 
    WHERE c_custkey = o_custkey AND c_nationkey = n_nationkey
    Group by n_name 
    Order by count(o_totalprice) ASC 
    LIMIT 1) as O
WHERE c_nationkey = n_nationkey AND o_custkey = c_custkey
GROUP BY n_name
HAVING count(o_totalprice) = (T);