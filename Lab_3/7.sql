SELECT substr(l_receiptdate, 1, 7), count(l_linenumber)
FROM customer, orders, lineitem
WHERE c_name ="Customer#000000020" 
      AND c_custkey = o_custkey 
      AND l_orderkey = o_orderkey
group by substr(l_receiptdate, 1, 7);
      
-- How many line items did Customer#000000020 order? 
-- Print the number of ordered line items 
-- corresponding to every (year, month) pair.