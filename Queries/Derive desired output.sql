-- Using the Source and Target table, write a query to arrive at the Output table as shown in below image. Provide the solution without using subqueries.
-- Solution using Left, Right, Inner JOIN and UNION operator
SELECT s.id, 'Mismatch' AS Comment -- creat new column Comment and its value is 'Mismatch'
FROM source s
JOIN target t ON s.id = t.id AND s.name <> t.name

	UNION

SELECT s.id, 'New in source' AS Comment
FROM source s
LEFT JOIN target t ON s.id = t.id
WHERE t.id IS NULL

	UNION

SELECT t.id, 'New in target' AS Comment
FROM source s
RIGHT JOIN target t ON s.id = t.id
WHERE s.id IS NULL;