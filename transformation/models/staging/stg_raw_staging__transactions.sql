with source as (

    select * from {{ source('raw', 'transactions') }}

),

renamed as (

    select
        transaction_id,
        cast(strptime(transaction_date, '%d.%m.%Y') as date) as transaction_date,
        account_id,
        trim(transaction_type) as transaction_type,
        cast(replace(transaction_amount,',','.') as float) as transaction_amount,
        trim(transaction_currency) as transaction_currency

    from source

)

select * from renamed