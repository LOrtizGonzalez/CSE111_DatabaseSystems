SELECT o_orderpriority,count(distinct o_orderkey)
FROM orders, lineitem, customer
WHERE c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    AND o_orderdate BETWEEN '1997-10-01' AND'1997-12-31'
    AND l_commitdate > l_receiptdate
GROUP BY o_orderpriority

-- Count the number of orders made in 
-- the fourth quarter of 1997 in which 
-- at least one line item was received 
-- by a customer earlier than its 
-- commit date. List the count of such 
-- orders for every order priority