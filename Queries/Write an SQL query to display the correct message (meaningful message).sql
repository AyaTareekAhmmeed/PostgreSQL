/* Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */
-- Solution using CASE statement
SELECT CASE WHEN translation IS NULL THEN comment ELSE translation END AS output
FROM comments_and_translations;

-- Solution using a built in function
SELECT COALESCE(translation, comment) AS output
FROM comments_and_translations;