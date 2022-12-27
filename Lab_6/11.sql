SELECT n_name
FROM nation, customer, 
    (SELECT COUNT(c_custkey) as C 
    FROM nation, customer 
    WHERE n_nationkey = c_nationkey 
    Group by n_name 
    Order by COUNT(c_custkey) ASC 
    LIMIT 1) as O
WHERE n_nationkey = c_nationkey
Group by n_name
Having COUNT(c_custkey) = (C);