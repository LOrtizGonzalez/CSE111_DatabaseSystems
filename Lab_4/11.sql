SELECT r_name, s_name, MAX(s_acctbal)
FROM region, supplier, nation
WHERE s_nationkey = n_nationkey AND
      n_regionkey = r_regionkey
GROUP BY r_name

-- Find the supplier with the largest account balance 
-- in every region. Print the region name, the supplier
-- name, and the account balance.