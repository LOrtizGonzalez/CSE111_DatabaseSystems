SELECT DISTINCT c_mktsegment,sum(c_acctbal)
FROM customer
group by c_mktsegment;

-- SELECT count(distinct c_mktsegment)
-- FROM customer