SELECT n_name, count(DISTINCT o_orderkey)
FROM orders, supplier, nation, lineitem
WHERE s_nationkey = n_nationkey AND
      o_orderdate LIKE '1995-%-%' AND
      s_suppkey = l_suppkey AND
      o_orderkey = l_orderkey AND 
      o_orderstatus = 'F'
GROUP BY n_name
HAVING count(DISTINCT o_orderkey) > 50


-- Find the number of distinct orders completed in
-- 1995 by the suppliers in every nation. An order status
-- of F stands for complete. Print only those nations 
-- for which the number of orders is larger than 50.
