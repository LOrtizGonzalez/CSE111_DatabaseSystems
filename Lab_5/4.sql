SELECT n_name, count(DISTINCT c_custkey), count(DISTINCT s_suppkey)
FROM customer, supplier, nation, region
WHERE c_nationkey = n_nationkey
      AND n_regionkey = r_regionkey
      AND r_name = "AFRICA"
      AND s_nationkey = c_nationkey
GROUP BY n_name

--  How many customers and suppliers 
--  are in every country from AFRICA?