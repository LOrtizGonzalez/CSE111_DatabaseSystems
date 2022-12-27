SELECT substr(o_orderdate, 1, 4), count(l_quantity)
FROM lineitem, orders, supplier, nation
WHERE o_orderpriority = "3-MEDIUM" 
    AND (n_name = "GERMANY" OR n_name = "FRANCE")
    AND s_nationkey = n_nationkey
    AND l_suppkey = s_suppkey
    AND o_orderkey = l_orderkey
GROUP BY substr(o_orderdate, 1, 4)

-- Find the total number of line items on 
-- orders with priority 3-MEDIUM supplied 
-- by suppliers from GERMANY and FRANCE. 
-- Group these line items based on the year 
-- of the order from o orderdate. Print
-- the year and the count. Check the substr 
-- function in SQLite.