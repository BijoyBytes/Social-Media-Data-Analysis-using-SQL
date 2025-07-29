# Social Media Database Analysis

## Overview
This repository contains SQL scripts for creating and analyzing a social media database (`socialmediadb`). The database models a platform similar to Instagram, with tables for users, photos, comments, likes, follows, tags, and photo-tag relationships. The included queries in `Research Question.sql` extract insights about user behavior, such as identifying the oldest users, detecting bot-like activity, and analyzing posting patterns.

## Database Schema
The `socialmediadb` database is defined in `Table Creation.sql` and includes the following tables:

- **`users`**: Stores user information (`id`, `username`, `created_at`).
- **`photos`**: Stores photo details (`id`, `image_url`, `user_id`, `created_dat`).
- **`comments`**: Stores comments on photos (`id`, `comment_text`, `user_id`, `photo_id`, `created_at`).
- **`likes`**: Stores photo likes (`user_id`, `photo_id`, `created_at`).
- **`follows`**: Stores follower relationships (`follower_id`, `followee_id`, `created_at`).
- **`tags`**: Stores unique tags (`id`, `tag_name`, `created_at`).
- **`photo_tags`**: Junction table linking photos to tags (`photo_id`, `tag_id`).

The schema includes foreign key constraints to maintain referential integrity and sample data for 100 users, 257 photos, 21 tags, and associated relationships.

## Research Questions and Queries
The `Research Question.sql` file contains queries to answer the following:

1. **Find the 5 Oldest Users**  

Retrieves the five earliest registered users based on `created_at`.  
**Selects** `id`, `username`, and `created_at` from the `users` table, ordered by `created_at` in ascending order, limited to 5 results.


3. **Users Who Commented on Their Own Photos**  
   Identifies users who commented on their own photos, indicating self-engagement.

   
   **Query: Joins comments, photos, and users tables to match comments where the commenter is the photo owner.**

5. **Top 5 Users with Most Followers**  
   Ranks users by follower count to find the most popular accounts.
   
   **Query:** Joins users and follows tables, groups by user, and orders by follower count in descending order, limited to 5.

7. **Most Popular Registration Days**  
   Determines which days of the week have the highest user registrations.
   
   **Query:** Joins users and follows tables, groups by user, and orders by follower count in descending order, limited to 5.
9. **Identify Potential Bots**  
   Detects users who liked every photo on the platform, suggesting bot-like behavior.
   
   **Query:** Joins users and follows tables, groups by user, and orders by follower count in descending order, limited to 5.
11. **Average Posts per User and Total Photos**  
   Calculates the average number of photos per user and totals for photos and users.
    **Query:** Joins users and follows tables, groups by user, and orders by follower count in descending order, limited to 5.

12. **Tags Used by a Specific User**  
   Lists unique tags used by a specified user (e.g., `Harley_Lind18`) in their photos.

   **Query:** Joins users and follows tables, groups by user, and orders by follower count in descending order, limited to 5.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/social-media-analysis.git
