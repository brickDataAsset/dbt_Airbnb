WITH li AS (
    SELECT * FROM {{ ref('dim_listings_cleansed') }}
),
ho AS (
    SELECT * FROM {{ ref("dim_hosts_cleansed") }}
)
SELECT li.listing_id,
       li.listing_name,
       li.room_type,
       li.minimum_nights,
       li.price,
       li.host_id,
       ho.host_name,
       ho.is_superhost,
       li.created_at,
       GREATEST(li.updated_at, ho.updated_at) AS updated_at 
FROM li
LEFT JOIN ho ON li.host_id=ho.host_id
