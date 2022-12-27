-- How many suppliers in every region have 
-- less balance in their account than the 
-- average account balance of their own 
-- region?

SELECT R.r_name, count(n_name)
FROM region R, nation, supplier,(SELECT r1.r_name AS name, avg(s_acctbal) AS average
                       FROM supplier s1, region r1, nation n1
                       WHERE s1.s_nationkey = n1.n_nationkey
                             AND n1.n_regionkey = r1.r_regionkey
                       GROUP BY r1.r_name
                       ) 
WHERE s_nationkey = n_nationkey
      AND n_regionkey = r_regionkey
      AND s_acctbal < average
      AND R.r_name = name
GROUP BY R.r_name
