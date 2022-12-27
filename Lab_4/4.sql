SELECT s_name, count(p_partkey)
FROM part, supplier, partsupp, nation
WHERE p_size < 20 AND
      p_partkey = ps_partkey AND
      ps_suppkey = s_suppkey AND
      s_nationkey = n_nationkey AND
      n_name = "CANADA"
GROUP BY s_name;

-- How many parts with size below 20 does 
-- every supplier from CANADA offer? Print 
-- the name of the
-- supplier and the number of parts.