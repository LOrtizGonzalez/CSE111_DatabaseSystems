-- 6. Find the supplier-customer pair(s) 
-- with the least expensive (o totalprice) 
-- order(s) completed (F in o orderstatus). 
-- Print the supplier name, the customer name, 
-- and the total price.

SELECT s1.s_name, c1.c_name, (SELECT min(o_totalprice) FROM orders) minimum--o1.o_totalprice
FROM supplier s1, customer c1, orders o1,
    (SELECT s_name, c_name, o_totalprice, o_orderstatus
    FROM supplier, customer, orders, lineitem
    WHERE c_custkey = o_custkey
        AND o_orderstatus = "F"
        AND o_orderkey = l_orderkey
        AND l_suppkey = s_suppkey
    ) SP
WHERE SP.o_totalprice = minimum
    --o1.o_totalprice = (SELECT min(o_totalprice) FROM orders)
    AND s1.s_name = SP.s_name
    AND c1.c_name = SP.c_name
GROUP BY s1.s_name, c1.c_name
-------------------------------------------------------------------------
-- (SELECT s_name, c_name, o_orderkey
-- FROM supplier, customer, orders, lineitem
-- WHERE c_custkey = o_custkey
--     AND o_orderstatus = "F"
--     AND o_orderkey = l_orderkey
--     AND l_suppkey = s_suppkey
-- ) SP

-- (SELECT min(o_totalprice)
-- FROM orders
-- )