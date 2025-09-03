{{
    config(
        materialized='incremental',
        unique_key='currency_iso_code'
    )
}}

select 
    currency_iso_code
    , currency  
from {{ ref("currencies") }}
