SELECT MIN(l_discount)
FROM lineitem, orders
WHERE o_orderdate LIKE '1996-10-%'
      AND l_orderkey = o_orderkey
      AND l_discount > 
            (SELECT AVG(l_discount)
            FROM lineitem, orders
            WHERE o_orderdate LIKE '1996-10-%'
                  AND l_orderkey = o_orderkey)

-- For the line items ordered in October 1996 
-- (o orderdate), find the smallest discount 
-- that is larger than the average discount 
-- among all the orders