SELECT count(distinct s_suppkey)
FROM part,lineitem, supplier
WHERE p_type LIKE '%POLISHED%'
    AND p_partkey = l_partkey
    AND s_suppkey = l_suppkey
    AND p_size IN (3,23,36,49)


-- Count the number of distinct suppliers 
-- that supply parts whose type contains 
-- POLISHED and have size
-- equal to any of 3, 23, 36, and 49.