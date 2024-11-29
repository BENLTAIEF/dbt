with src_listings as (
    select *
    from {{ref('src_listings')}}
)
select listing_id
    ,listing_name
    ,room_type
    ,case when minimum_nights=0 or minimum_nights is null then 1 else minimum_nights end as minimum_nights
    ,host_id
    ,cast(replace(price_str, '$', '') as DECIMAL(10, 2 )) as price
    ,created_at
    ,updated_at
from src_listings
where host_id not in(1, 2, 4, 7, 15)