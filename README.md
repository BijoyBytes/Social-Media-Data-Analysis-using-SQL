# Social Media Database Analysis

## Overview
**Project Title**: Social Media Data Analysis Using SQL   
**Level**: Intermediate  
**Database**: `socialmediadb`

This repository contains SQL scripts for creating and analyzing a social media database (`socialmediadb`). The database models a platform similar to Instagram, with tables for users, photos, comments, likes, follows, tags, and photo-tag relationships. The included queries in `Research Question.sql` extract insights about user behavior, such as identifying the oldest users, detecting bot-like activity, and analyzing posting patterns.


![Customer Distribution](https://github.com/BijoyBytes/Social-Media-Data-Analysis-using-SQL/blob/main/Analysis%20picture.png) 


## Project Structure

### 1. Database Setup

![Customer Distribution](https://github.com/BijoyBytes/Social-Media-Data-Analysis-using-SQL/blob/main/Table%20Relationship.png) 
- **Database Creation**: Created a database named `socialmediadb`.
- **Table Creation**: Created tables for users, photos, comments, likes, follows, tags and photo_tags. Each table includes relevant columns and relationships.

```sql
  
USE socialmediadb;

/*Users*/
CREATE TABLE users(
	id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
	username VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

/*Photos*/
CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(355) NOT NULL,
	user_id INT NOT NULL,
	created_dat TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

/*Comments*/
CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id)
);

/*Likes*/
CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	PRIMARY KEY(user_id,photo_id)
);

/*follows*/
CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (follower_id) REFERENCES users(id),
	FOREIGN KEY (followee_id) REFERENCES users(id),
	PRIMARY KEY(follower_id,followee_id)
);

/*Tags*/
CREATE TABLE tags(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

/*junction table: Photos - Tags*/
CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id,tag_id)
);
```
### 2. Key SQL Analyses & Insights
**Task 1: Users With More Followers Than Following**  
Business Insight: Identifies high-authority or popular users

```sql
SELECT u.username FROM users u
WHERE (SELECT COUNT(*) FROM follows WHERE followee_id = u.id) >
      (SELECT COUNT(*) FROM follows WHERE follower_id = u.id);
```
📈 These users often act as influencers or content leaders.

**Task 2. Users Commenting on Their Own Photos**
Business Insight: Detects self-engagement behaviour.

```sql
SELECT DISTINCT u.username
FROM comments c
JOIN photos p ON c.photo_id = p.id
JOIN users u ON c.user_id = u.id
WHERE c.user_id = p.user_id;
```
**Task 3. Top 5 Users by Follower Count**
Business Insight: Identifies top influencers for marketing or partnerships.

```sql
SELECT u.username, COUNT(f.follower_id) AS total_followers
FROM users u
JOIN follows f ON u.id = f.followee_id
GROUP BY u.id
ORDER BY total_followers DESC
LIMIT 5;
```
**Task 4. Bot Detection: Users Who Liked Every Photo**
Business Insight: Flags suspicious automated activity.

```sql
with base as(select u.username as users,count(photo_id) as likes from likes l join users u on
l.user_id = u.id
group by u.username)
select users from base
where likes = (select count(*) from photos)
Limit 5;
```
🚨 Such behaviour is statistically abnormal and useful for moderation systems.

**Task 8. Determine users who are "Influencers" (Followed by more than 50 people).**
```SQL
SELECT u.username, COUNT(f.follower_id) AS follower_count
FROM users u
JOIN follows f ON u.id = f.followee_id
GROUP BY u.id
HAVING follower_count > 50;
```

## Advanced SQL Operations
**Task 7. Average Posting Behaviour**
Business Insight: Measures overall platform engagement.

```sql
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
```
📊 Reveals content creation imbalance — a small group creates most content.

## Key Insights
- The top 5 most-followed accounts on the platform collectively hold approximately 5.05% of the total follows
- 13 users liked every photo → likely automated/bot behaviour
- Average user posts only 2.6 photos → content creation is skewed

## Conclusion
This project demonstrates how SQL can be used as an analytical tool, not just a querying language, to understand user behavior on a social media platform.

By designing a normalized relational database and writing advanced SQL queries, meaningful insights were extracted around user engagement, influence, and abnormal activity.

Thank you for your interest in this project!
