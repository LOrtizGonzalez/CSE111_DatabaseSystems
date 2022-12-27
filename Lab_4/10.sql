SELECT p_type, min(l_discount), max(l_discount)
FROM lineitem, part 
WHERE p_type like "ECONOMY%COPPER" AND
      p_partkey = l_partkey
GROUP BY p_type

-- Find the minimum and maximum discount for 
-- every part having ECONOMY and COPPER in its type.