-- 7. Find how many suppliers have less 
-- than 50 distinct orders from customers 
-- in GERMANY and FRANCE together.

SELECT count(PS.s_name)
FROM 
    (SELECT s_name, count(distinct o_orderkey) cnt
    FROM supplier, orders, lineitem, customer, nation
    WHERE s_suppkey = l_suppkey
        AND l_orderkey = o_orderkey
        AND o_custkey = c_custkey
        AND c_nationkey = n_nationkey 
        AND (n_name = "GERMANY" OR n_name = "FRANCE")
    GROUP BY s_name) PS
WHERE cnt < 50



-- SELECT c_custkey, count(DISTINCT o_orderkey)
-- FROM customer, orders, nation
-- WHERE c_custkey = o_custkey
--     AND c_nationkey = n_nationkey
--     AND n_name = ("GERMANY" OR "FRANCE")
-- GROUP BY c_custkey
