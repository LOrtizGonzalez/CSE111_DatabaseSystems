SELECT c_name, count(o_orderkey)
FROM orders, customer, nation
WHERE o_custkey = c_custkey AND
      c_nationkey = n_nationkey AND
      n_name = "GERMANY" AND
      o_orderdate > '1992-12-31' AND
      o_orderdate < '1994-01-01'
GROUP BY c_name;


--  Find the number of orders posted 
--  by every customer from GERMANY in 1993.