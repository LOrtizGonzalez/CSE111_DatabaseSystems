SELECT r_name, count(o_orderstatus)
FROM orders, customer, nation, region
WHERE o_orderstatus = 'P' AND
      o_custkey = c_custkey AND
      c_nationkey = n_nationkey AND
      n_regionkey = r_regionkey
GROUP BY r_name
