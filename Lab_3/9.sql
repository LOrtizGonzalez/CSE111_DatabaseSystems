SELECT DISTINCT(n_name),count(s_suppkey), MIN(s_acctbal)
FROM nation, supplier
WHERE n_nationkey = s_nationkey
GROUP BY n_name 
HAVING count(s_nationkey) > 5