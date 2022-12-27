SELECT s_name, s_acctbal
FROM nation, region, supplier
WHERE s_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'EUROPE' AND
    s_acctbal > 7000;
