# Netflix Data Analysis

## Project Overview

This project involves analyzing data from the Netflix platform to gain insights into its content, ratings, countries, and more. The analysis includes various SQL queries on a Netflix dataset, covering a wide range of questions about Movies, TV Shows, Directors, Ratings, and Countries. This project aims to help explore patterns in content availability, director contributions, ratings distribution, and other important attributes of Netflix content.

### Key Technologies:
- **SQL**: Used for querying and analyzing data in a PostgreSQL database.
- **Data Analysis**: Conducting exploratory data analysis using SQL queries to extract valuable insights from Netflix content data.
- **PostgreSQL**: Database used for storing and querying the Netflix dataset.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## SQL Queries Categories

This project contains SQL queries categorized by difficulty:

1. **Easy SQL Queries**: Basic queries for getting simple insights like total count, specific genres, and movies by year.
2. **Medium SQL Queries**: Queries that involve joins, advanced aggregations, and filtering based on multiple conditions.
3. **Difficult SQL Queries**: Advanced queries involving window functions, CTEs, and complex aggregations to extract deeper insights.

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(7),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   DATE,
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(200),
    listed_in    VARCHAR(300),
    description  VARCHAR(550)
);
```

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)


