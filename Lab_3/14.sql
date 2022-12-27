SELECT count(o_orderpriority)
FROM orders, customer
WHERE o_orderpriority = '1-URGENT' AND
      o_custkey = c_custkey AND
      c_nationkey = 17 AND 
      o_orderdate < '1998-01-01' AND
      o_orderdate > '1994-12-31'

-- Find how many 1-URGENT priority orders have been 
--posted by customers from PERU between 1995 and
-- 1997, combined.