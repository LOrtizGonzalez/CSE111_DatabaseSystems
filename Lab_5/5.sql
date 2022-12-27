--  For parts whose type contains STEEL, 
--  return the name of the supplier from 
--  ASIA that can supply them at minimum 
--  cost (ps supplycost), for every part 
--  size. Print the supplier name together 
--  with the part size and the minimum cost.

SELECT s_name, p_size AS P, min(ps_supplycost) AS M 
FROM part, partsupp, supplier, region, nation
WHERE p_type like "%STEEL" 
      AND r_name = "ASIA" 
      AND n_regionkey = r_regionkey 
      AND s_nationkey = n_nationkey 
      AND ps_suppkey = s_suppkey 
      AND p_partkey = ps_partkey
GROUP BY p_size ORDER BY s_name ASC;
