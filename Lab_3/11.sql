SELECT count(DISTINCT c_custkey)
FROM customer, lineitem, orders
where c_custkey = o_custkey AND
      o_orderkey = l_orderkey AND
      l_discount >= 0.07;

