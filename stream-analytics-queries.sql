-- Stream Analytics Queries
-- Ref: timw.info/uat

SELECT *
FROM TwitterStream

SELECT System.Timestamp as Time, text
FROM TwitterStream
WHERE text LIKE '%Azure%'

-- get the count of mentions by topic every 5 seconds.

SELECT System.Timestamp as Time, Topic, COUNT(*)
FROM TwitterStream TIMESTAMP
BY CreatedAt
GROUP BY TUMBLINGWINDOW
(s, 5), Topic

--check for topics that are mentioned more than 20 times in the last 5 seconds
SELECT System.Timestamp as Time, Topic, COUNT(*) as Mentions
FROM TwitterStream TIMESTAMP
BY CreatedAt
GROUP BY SLIDINGWINDOW
(s, 5), topic
HAVING COUNT
(*) > 20

-- obtain the number of mentions and average, minimum, maximum, and standard deviation of sentiment score for each topic every 5 seconds.
SELECT System.Timestamp as Time, Topic, COUNT(*), AVG(SentimentScore), MIN(SentimentScore),
  Max(SentimentScore), STDEV(SentimentScore)
FROM TwitterStream TIMESTAMP
BY CreatedAt
GROUP BY TUMBLINGWINDOW
(s, 5), Topic
