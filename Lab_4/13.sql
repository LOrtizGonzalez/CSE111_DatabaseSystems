SELECT count(l_orderkey)
FROM lineitem, supplier, nation N1, nation N2, 
     region, orders, customer
WHERE o_custkey = c_custkey
      AND c_nationkey = N1.n_nationkey
      AND N1.n_name = "UNITED STATES"
      AND l_orderkey = o_orderkey
      AND l_suppkey = s_suppkey
      AND s_nationkey = N2.n_nationkey 
      AND r_name = "AFRICA"
      AND N2.n_regionkey = r_regionkey


-- How many line items are supplied by suppliers 
-- in AFRICA for orders made by customers in UNITED
-- STATES?