{{
    config(
        materialized='incremental',
        unique_key='currency_iso_code'
    )
}}

select 
    trim(currency_iso_code) as currency_iso_code
    , trim(currency) as currency 
from {{ ref("currencies") }}
