SELECT c_name, SUM(o_totalprice)
FROM customer, nation, orders
WHERE o_custkey = c_custkey AND
      c_nationkey = n_nationkey AND
      n_name ="FRANCE" AND
      o_orderdate < '1996-01-01' AND
      o_orderdate >'1994-12-31'
GROUP BY c_name;

-- Find the total price paid on orders by every customer 
-- from FRANCE in 1995. Print the customer name
-- and the total price.
