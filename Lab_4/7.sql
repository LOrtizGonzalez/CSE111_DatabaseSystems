SELECT n_name, o_orderstatus, count(o_orderstatus)
FROM customer, nation, orders, region
WHERE r_name = "AMERICA" AND
      n_regionkey = r_regionkey AND
      o_custkey = c_custkey AND
      c_nationkey = n_nationkey
GROUP BY n_name, o_orderstatus

-- How many orders do customers in every nation 
-- in AMERICA have in every status? Print the nation
-- name, the order status, and the count.