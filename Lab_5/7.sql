SELECT o_orderpriority, count(p_partkey)
FROM orders, lineitem, part
WHERE l_orderkey = o_orderkey
    AND o_orderdate LIKE '1997-%-%'
    AND l_receiptdate > l_commitdate
    AND p_partkey = l_partkey
GROUP BY o_orderpriority

-- For every order priority, count 
-- the number of parts ordered in 1997 
-- and received later (l receiptdate)
-- than the commit date (l commitdate).