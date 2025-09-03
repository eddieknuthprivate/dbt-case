{{
    config(
        materialized='incremental',
        unique_key='currency_iso_code'
    )
}}

select * from {{ ref("currencies") }}
