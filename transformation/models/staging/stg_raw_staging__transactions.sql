with source as (

    select * from {{ source('raw', 'transactions') }}

),

renamed as (

    select
        transaction_id,
        transaction_date,
        account_id,
        transaction_type,
        cast(replace(transaction_amount,',','.') as float) as transaction_amount,
        transaction_currency

    from source

)

select * from renamed