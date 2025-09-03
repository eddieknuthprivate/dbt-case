
{{
    config(
        materialized='incremental',
        unique_key='currency_iso_code'
    )
}}

select * from {{ ref("stg_raw_staging__fx_rates") }}