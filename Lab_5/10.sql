--  How many customers from every region 
--  have never placed an order and have 
--  less than the average account balance?

SELECT R1.r_name, count(distinct C1.c_custkey)
FROM customer C1, region R1, nation N1, ( SELECT r_name, avg(c_acctbal) average
                                        FROM region, customer, nation
                                        WHERE c_nationkey = n_nationkey
                                        AND n_regionkey = r_regionkey
                                        )
WHERE C1.c_acctbal < average
        AND R1.r_regionkey = N1.n_regionkey
        AND N1.n_nationkey = C1.c_nationkey
        AND C1.c_custkey not in (SELECT distinct c_custkey
                                FROM customer, orders, lineitem
                                WHERE c_custkey = o_custkey
                                        AND o_orderkey = l_orderkey
                                )
GROUP BY R1.r_name