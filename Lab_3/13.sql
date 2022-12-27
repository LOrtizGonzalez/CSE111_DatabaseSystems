SELECT sum(c_acctbal)
FROM customer, nation
WHERE c_mktsegment = 'MACHINERY' AND
      c_nationkey = n_nationkey AND
      n_regionkey = 2

--Find the total account balance of all the 
--customers from ASIA in the MACHINERY market segment.