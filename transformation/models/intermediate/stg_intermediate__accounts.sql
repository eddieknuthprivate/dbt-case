{{
    config(
        materialized='incremental',
        unique_key='account_id'
    )
}}

select 
    *
from {{ ref("stg_raw_staging__accounts") }}
