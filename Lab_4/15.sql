SELECT count(DISTINCT o_orderkey)
FROM orders, customer, supplier, lineitem
WHERE o_custkey = c_custkey AND
      l_suppkey = s_suppkey AND
      c_acctbal > 0 AND
      s_acctbal < 0 AND
      l_orderkey = o_orderkey

--  How many distinct orders are between customers 
--  with positive account balance and suppliers with
-- negative account balance?