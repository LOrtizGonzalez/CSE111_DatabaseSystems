SELECT n_name, max(s_acctbal)
FROM supplier, nation
WHERE s_nationkey = n_nationkey
GROUP BY n_name
HAVING max(s_acctbal) > 9000

-- What is the maximum account balance for the 
-- suppliers in every nation? Print only those nations for
-- which the maximum balance is larger than 9000.