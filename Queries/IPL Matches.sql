/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */
select * from teams

-- Each team plays with every other team JUST ONCE.
WITH matches AS
	(SELECT row_number() over(order by team_name) AS id, t.*
	 FROM teams t)
	 
SELECT team.team_name AS team, opponent.team_name AS opponent
FROM matches team
JOIN matches opponent ON team.id < opponent.id
ORDER BY team;

-- Each team plays with every other team TWICE.
WITH matches AS
	(SELECT row_number() over(order by team_name) AS id, t.*
	 FROM teams t)

SELECT team.team_name AS team, opponent.team_name AS opponent
FROM matches team
JOIN matches opponent ON team.id <> opponent.id
ORDER BY team;
