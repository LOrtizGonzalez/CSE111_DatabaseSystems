SELECT s_name, o_orderpriority, count(DISTINCT p_partkey)
FROM nation, supplier, orders, lineitem, part
WHERE n_name = "CANADA" 
      AND s_nationkey = n_nationkey
      AND l_partkey = p_partkey
      AND l_suppkey = s_suppkey
      AND l_orderkey = o_orderkey
GROUP BY s_name, o_orderpriority;

-- SELECT s_name, o_orderpriority, count(DISTINCT (l_partkey))
-- FROM part, partsupp, supplier, nation, orders, lineitem
-- WHERE p_partkey = ps_partkey AND --
--       ps_suppkey = s_suppkey AND --
--       s_nationkey = n_nationkey AND --
--       --o_orderkey = s_suppkey AND 
--       n_name = "CANADA" AND 
--       l_orderkey = o_orderkey AND --
--       l_partkey = p_partkey-- 
-- GROUP BY s_name, o_orderpriority


-- How many unique parts produced by 
-- every supplier in CANADA are ordered 
-- at every priority? Print the
-- supplier name, the order priority, 
-- and the number of parts.