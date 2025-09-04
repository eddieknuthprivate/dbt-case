

with source as (

    select * from {{ source('raw', 'accounts') }}

),

renamed as (

    select
        account_id,
        customer_id,
        trim(account_type) as account_type,
        cast(null as date) as account_opening_date
    from source where account_opening_date = ''
    union all
    select
        account_id,
        customer_id,
        trim(account_type) as account_type,
        cast(strptime(account_opening_date, '%d.%m.%Y') as date) as account_opening_date
    from source where account_opening_date != ''

)

select * from renamed