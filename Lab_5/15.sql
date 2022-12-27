SELECT sum(l_extendedprice * (1 - l_discount)) / (SELECT sum(l_extendedprice * (1 - l_discount))

    FROM lineitem, supplier, customer, nation N1, nation N2, region, orders
    WHERE r_name == "ASIA" 
        AND N1.n_regionkey == r_regionkey --
        AND c_nationkey == N1.n_nationkey--
        AND s_nationkey == N2.n_nationkey 
        AND N2.n_name 
            NOT IN (SELECT r_name 
            FROM region 
            WHERE r_name == "UNITED STATES") 
                AND c_custkey == o_custkey
                AND o_orderkey == l_orderkey 
                AND l_suppkey == s_suppkey
                AND  l_shipdate like "1997-%-%")

FROM lineitem, supplier, customer, nation N1, nation N2, region, orders
WHERE r_name == "ASIA" 
    AND N1.n_regionkey == r_regionkey 
    AND c_nationkey == N1.n_nationkey
    AND s_nationkey == N2.n_nationkey 
    AND N2.n_name == "UNITED STATES" 
    AND c_custkey == o_custkey 
    AND o_orderkey == l_orderkey 
    AND l_suppkey == s_suppkey 
    AND l_shipdate like "1997-%-%"