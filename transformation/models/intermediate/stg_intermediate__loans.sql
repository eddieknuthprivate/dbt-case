{{
    config(
        materialized='incremental',
        unique_key='loan_id'
    )
}}

select * from {{ ref("stg_raw_staging__loans") }}