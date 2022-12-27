SELECT R1.r_name, R2.r_name, MAX( o_totalprice)
FROM region R1, region R2, nation N1, nation N2, 
     customer, supplier, orders, lineitem
WHERE o_custkey = c_custkey 
      AND o_orderkey = l_orderkey
      AND l_suppkey = s_suppkey
      AND N1.n_regionkey = R1.r_regionkey --
      AND s_nationkey = N1.n_nationkey
      AND N2.n_regionkey = R2.r_regionkey --
      AND c_nationkey = N2.n_nationkey
GROUP BY R1.r_name, R2.r_name
HAVING MAX(o_totalprice);

-- List the maximum total price of an order 
-- between any two regions, i.e., the suppliers 
-- are from one region and the customers are from 
-- the other region.