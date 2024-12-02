{{
    config(
    materialized = 'incremental',
    on_schema_change = 'fail'
    )
}}
with src_reviews as(
    select *
    from {{ref("src_reviews")}}
)
select
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id
    ,listing_id
    ,review_date
    ,reviewer_name
    ,review_text
    ,review_sentiment
from src_reviews
where review_text is not null
{% if is_incremental() %}
    {% if var('start_date', False) and var('end_date', False) %}
        {{ log ("Loading " ~ this ~ " incrementally (start_date: " ~ var("start_date") ~ " End Date :" ~ var("end_date") ~ " )" , info=True) }}
        and review_date >= '{{ var("start_date") }}'
        and review_date <  '{{ var("end_date") }}'
    {% else %}
        {{ log ("Loading " ~ this ~ " incrementally ( all missing dates )" , info=True) }}
        and review_date >= coalesce((select max(review_date) from {{ this }}), '1900-01-01')    
    {% endif %}
  
{% endif %}