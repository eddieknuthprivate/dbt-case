
with source as (

    select * from {{ source('raw', 'fx_rates') }}

),

renamed as (

    select
        trim(currency_iso_code) as currency_iso_code,
        cast(replace(fx_rate,',','.') as float) as fx_rate,
        cast(strptime(date, '%d.%m.%Y') as date) as fx_rate_date

    from source
    where currency_iso_code is not null or currency_iso_code != ''

)

select * from renamed