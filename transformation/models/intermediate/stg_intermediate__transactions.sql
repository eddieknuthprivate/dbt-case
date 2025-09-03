{{
    config(
        materialized='incremental',
        unique_key='transaction_id'
    )
}}

select 
    * 
from {{ ref("stg_raw_staging__transactions") }}