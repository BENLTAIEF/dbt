{% snapshot scd_raw_listings %}

{{
   config(
       target_database='dbt_dev',
       target_schema='dbo',
       unique_key='id',

       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}}

select *
from {{ source('dbt_dev', 'listings') }}

{% endsnapshot %}