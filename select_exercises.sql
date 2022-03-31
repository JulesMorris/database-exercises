USE albums_db;

-- Explore the structure of the albums table.
-- a. How many rows are in the albums table?
	-- 31
SELECT COUNT(*)
FROM albums;
-- b. How many unique artist names are in the albums table?
	-- 23
SELECT COUNT(DISTINCT artist)
FROM albums;
-- c. What is the primary key for the albums table?
	-- id 
DESCRIBE albums;
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
	-- 1967
    -- 2011 
SELECT MIN(release_date)
FROM albums;

SELECT MAX(release_date)
FROM albums;

-- a. The name of all albums by Pink Floyd
	-- The Dark Side of the Moon
    -- The Wall
    
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';
-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
	-- 1967
SELECT release_date, name
FROM albums;
		-- Use double quotations when there is an apostraphe 

SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; 

-- c. The genre for the album Nevermind
	-- Grunge, Alternative rock
    
SELECT genre
FROM albums
WHERE name = 'Nevermind';

-- d. Which albums were released in the 1990s
		-- The Bodyguard, Jagged Little Pill, 
		-- Come on Over, Falling Into You, Let's Talk About Love,
        -- Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture,
        -- Metallica, Nevermind, Supernatural
SELECT name
FROM albums
WHERE release_date >= 1990 AND release_date <= 1999;
-- e. Which albums had less than 20 million certified sales

	-- Grease, Bad, Sgt. Pepper, Dirty Dancing, Let's Talk, Dangerous, 
    -- The Immaculate Collection, Abbey Road, Born in the USA, Brothers in Arms,
    -- Titanic, Nevermind, The Wall
SELECT name
FROM albums
WHERE sales < 20.0;

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
	-- Sgt. Pepper's, 1, Abbey Road, Born in the USA, Supernatural
    -- The query returned an explicit value of 'Rock' because I set the query to return that value.
    
SELECT name
FROM albums
WHERE genre = 'Rock';

	-- Provides better, more accurate results for albums with multiple genres 
SELECT name, genre
FROM albums
WHERE genre = 'Rock'
	OR genre LIKE 'Rock, %'
    OR genre LIKE '%, Rock, %'
    OR genre LIKE '%, Rock';