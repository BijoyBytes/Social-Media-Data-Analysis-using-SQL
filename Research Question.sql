USE socialmediadb;
-- 1. Find the 5 oldest user

SELECT id, username, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- 3. Users Who Commented on Their Own Photos

SELECT DISTINCT u.username
FROM comments c
JOIN photos p ON c.photo_id = p.id
JOIN users u ON c.user_id = u.id
WHERE c.user_id = p.user_id;

-- 4. Top 5 Users with Most Followers
SELECT u.username, COUNT(f.follower_id) AS total_followers
FROM users u
JOIN follows f ON u.id = f.followee_id
GROUP BY u.id
ORDER BY total_followers DESC
LIMIT 5;

-- 5. What day of the week do most of the users register on
SELECT 
  DAYNAME(created_at) AS registration_day,
  COUNT(*) AS total_users
FROM users
GROUP BY registration_day
ORDER BY total_users DESC
LIMIT 5;

-- 6. Identify users (bots) who have liked every single photo on the site, which is an abnormal behaviour 

with base as(select u.username as users,count(photo_id) as likes from likes l join users u on
l.user_id = u.id
group by u.username)
select users from base
where likes = (select count(*) from photos)
Limit 5;

-- 7. How many times does the average user post on Instagram? Also, provide the total number of photos on Instagram/total number of users 
WITH base AS (
  SELECT u.id, COUNT(p.id) AS total_post
  FROM users u
  LEFT JOIN photos p ON p.user_id = u.id
  GROUP BY u.id
)
SELECT 
  SUM(total_post) AS total_photos,
  COUNT(id) AS total_users,
  ROUND(SUM(total_post) * 1.0 / COUNT(id), 2) AS avg_photos_per_user
FROM base;

-- 8. List All Tags Used by a Specific User (e.g., 'Harley_Lind18')
SELECT DISTINCT t.tag_name
FROM tags t
JOIN photo_tags pt ON t.id = pt.tag_id
JOIN photos p ON pt.photo_id = p.id
JOIN users u ON p.user_id = u.id
WHERE u.username = 'Harley_Lind18';






