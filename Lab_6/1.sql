-- Find the total quantity (l quantity) 
-- of line items shipped per month 
-- (l shipdate) in 1995. Hint:
-- check function strftime to extract the
-- month/year from a date.

SELECT strftime('%m',l_shipdate) Month, sum( l_quantity) total
FROM lineitem
WHERE l_shipdate LIKE '1995-%-%'
GROUP BY strftime('%m', l_shipdate)