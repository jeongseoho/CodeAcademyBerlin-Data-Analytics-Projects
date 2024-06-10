-- 4.1 Select the title of all movies.
SELECT Title FROM Movies

-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT Rating FROM Movies

-- 4.3 Show all unrated movies.
SELECT * FROM Movies
WHERE Rating is null


-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT * FROM MovieTheaters
WHERE Movie is null

-- 4.5 Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT MovieTheaters.Code, MovieTheaters.Name, MovieTheaters.Movie, Movies.Title  
FROM MovieTheaters
JOIN Movies
ON Movies.Code = MovieTheaters.Movie

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT Movies.Code, Movies.Title, Movies.Rating, MovieTheaters.Name
FROM Movies
JOIN MovieTheaters
ON Movies.Code = MovieTheaters.Movie

-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT m.Title
FROM Movies m
LEFT JOIN MovieTheaters mt 
ON m.Code = mt.Movie
WHERE mt.Movie IS NULL;
	
-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies VALUES (9, 'One, Two, Three', NULL)

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies
SET Rating = 'G'
WHERE Rating is NULL

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM MovieTheaters
WHERE Movie IN (SELECT Code FROM Movies WHERE Rating = 'NC-17');

