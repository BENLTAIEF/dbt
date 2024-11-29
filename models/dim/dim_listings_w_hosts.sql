with src_dim_host as(
    select *
    from {{ ref('dim_hosts_cleansed') }}
)
,src_dim_listings as(
    select * 
    from {{ ref('dim_listings_cleansed') }}
)
select distinct b.listing_id
    ,b.listing_name
    ,b.room_type
    ,b.minimum_nights
    ,b.price
    ,b.host_id
    ,a.host_name
    ,a.is_superhost
    ,b.created_at as listing_created_at
    ,b.updated_at as listing_updated_at
    ,a.created_at as host_created_at
    ,a.updated_at as host_updated_at
from src_dim_host a
inner join src_dim_listings b on b.host_id = a.host_id