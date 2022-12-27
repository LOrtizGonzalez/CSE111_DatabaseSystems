SELECT n_name, count(n_regionkey)
FROM orders, nation, customer
WHERE o_custkey = c_custkey AND
      c_nationkey = n_nationkey AND
      n_regionkey =1
GROUP BY n_name;


--  How many orders are posted by customers 
--  in every country in AMERICA?