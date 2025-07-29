# Social-Media-Data-Analysis-using-SQL
# Social Media Database Analysis

## Overview
This repository contains SQL queries designed to analyze user behavior and engagement patterns in a social media database (`socialmediadb`). The queries address research questions to extract insights about user activity, such as identifying the oldest users, detecting bot-like behavior, and analyzing posting frequency on a platform resembling Instagram.

## Dataset
The analysis uses the `socialmediadb` relational database with the following key tables:
- `users`: Stores user details (`id`, `username`, `created_at`).
- `photos`: Stores photo information (`id`, `user_id`).
- `comments`: Stores comments on photos (`user_id`, `photo_id`).
- `likes`: Stores photo likes (`user_id`, `photo_id`).
- `follows`: Stores follower relationships (`follower_id`, `followee_id`).
- `tags` and `photo_tags`: Store tags and their associations with photos.

## Research Questions and Queries
The `Research Question.sql` file includes queries to answer the following:

1. **Find the 5 Oldest Users**  
   Retrieves the five earliest registered users based on `created_at`.

2. **Users Who Commented on Their Own Photos**  
   Identifies users who commented on their own photos, indicating self-engagement.

3. **Top 5 Users with Most Followers**  
   Ranks users by follower count to find the most popular accounts.

4. **Most Popular Registration Days**  
   Determines which days of the week have the highest user registrations.

5. **Identify Potential Bots**  
   Detects users who liked every photo on the platform, suggesting bot-like behavior.

6. **Average Posts per User and Total Photos**  
   Calculates the average number of photos per user and totals for photos and users.

7. **Tags Used by a Specific User**  
   Lists unique tags used by a specified user (e.g., `Harley_Lind18`) in their photos.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/social-media-analysis.git
