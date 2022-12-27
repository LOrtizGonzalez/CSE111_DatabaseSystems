SELECT sum(o_totalprice)
FROM orders, customer,nation
WHERE c_nationkey = n_nationkey AND
      n_regionkey = 2 AND
      o_orderdate < '1998-01-01' AND
      o_orderdate > '1996-12-31' AND
      c_custkey = o_custkey;