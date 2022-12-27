SELECT Q.p_name
FROM part Q, (SELECT P.p_name, min(l_extendedprice*(1-l_discount))
FROM lineitem, part P
WHERE l_partkey = p_partkey
      AND l_shipdate > '1996-10-02') X
WHERE Q.p_name = X.p_name


--  Find the lowest value line item(s) 
--  (l extendedprice*(1-l discount)) shipped 
--  after October 2,1996. Print the name of 
--  the part corresponding to these line item(s).