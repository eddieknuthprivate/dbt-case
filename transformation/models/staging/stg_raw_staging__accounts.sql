

with source as (

    select * from {{ source('raw', 'accounts') }}

),

renamed as (

    select
        account_id,
        customer_id,
        account_type,
        strptime(replace(account_opening_date, '', null), '%d.%m.%Y') as account_opening_date

    from source

)

select * from renamed