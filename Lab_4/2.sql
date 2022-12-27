SELECT r_name, count(r_regionkey)
FROM supplier, nation, region
WHERE s_nationkey = n_nationkey AND
      n_regionkey = r_regionkey
GROUP BY r_regionkey;


--  Find the number of suppliers 
--  from every region.