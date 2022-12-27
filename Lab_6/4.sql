-- 4. Find how many suppliers from 
-- UNITED STATES supply more than 40 
-- different parts

SELECT count(S.s_suppkey)
FROM supplier S,
    (SELECT s_suppkey, count(distinct p_partkey) cnt
    FROM supplier, part, partsupp, nation
    WHERE s_suppkey = ps_suppkey
        AND ps_partkey = p_partkey
        AND s_nationkey = n_nationkey
        AND n_name = "UNITED STATES"
    GROUP BY s_suppkey
    HAVING cnt > 40
    ) P
WHERE S.s_suppkey = P.s_suppkey
