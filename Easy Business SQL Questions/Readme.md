# Easy SQL Questions with Answers and Objectives

This repository contains a set of easy SQL questions along with their solutions and objectives. Each question focuses on a specific SQL concept to build your foundational skills.
---

## Questions, Objectives, and Answers


### 1. **Total Movies and TV Shows**


- **Question**: Write a query to find the total number of movies and TV shows available on the platform.

- **Answer**:

  ```sql
  SELECT type, COUNT(*) AS total_count
  FROM netflix
  GROUP BY type;
  
- **Objective**: This query reveals the total number of Movies and TV Shows available on the platform, broken down by their type

  
