-- SELECT p1.p_mfgr, MIN(ps1.ps_availqty)
-- FROM part p1, partsupp ps1, supplier
-- WHERE s_suppkey = 10
--       AND p_partkey = ps_partkey
--       AND ps_suppkey = s_suppkey; --gets me most popular item
      
SELECT Q.p_mfgr
FROM part Q, (select p1.p_mfgr, MIN(ps1.ps_availqty)
            FROM part p1, partsupp ps1, supplier
            WHERE s_suppkey = 10
                  AND p1.p_partkey = ps_partkey
                  AND ps_suppkey = s_suppkey
            ) P 
WHERE Q.p_mfgr = P.p_mfgr
GROUP BY Q.p_mfgr


-- Based on the available quantity of items, 
-- who is the manufacturer p mfgr of the most 
-- popular item (the more popular an item is, 
-- the less available it is in ps availqty) 
-- from Supplier#000000010?