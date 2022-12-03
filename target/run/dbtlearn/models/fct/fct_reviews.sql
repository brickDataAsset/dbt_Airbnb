

      create or replace transient table airbnb.dev.fct_reviews  as
      (
WITH  __dbt__cte__src_reviews as (
WITH raw_reviews AS (
    SELECT * FROM  airbnb.raw.raw_reviews
)
SELECT 
    listing_id,
    date AS review_date,
    reviewer_name,
    comments AS review_text,
    sentiment AS review_sentiment
FROM 
    raw_reviews
),src_reviews AS (
    SELECT * FROM __dbt__cte__src_reviews
) 
SELECT 
    md5(cast(coalesce(cast(listing_id as TEXT), '') || '-' || coalesce(cast(review_date as TEXT), '') || '-' || coalesce(cast(reviewer_name as TEXT), '') || '-' || coalesce(cast(review_text as TEXT), '') as TEXT)) AS review_id,
    * 
FROM src_reviews 
WHERE review_text IS NOT NULL

      );
    