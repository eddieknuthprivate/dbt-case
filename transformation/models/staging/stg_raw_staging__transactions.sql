with source as (

    select * from {{ source('raw', 'transactions') }}

),

renamed as (

    select
        transaction_id,
        cast(strptime(transaction_date, '%d.%m.%Y') as date) as transaction_date,
        account_id,
        transaction_type,
        cast(replace(transaction_amount,',','.') as float) as transaction_amount,
        transaction_currency

    from source

)

select * from renamed