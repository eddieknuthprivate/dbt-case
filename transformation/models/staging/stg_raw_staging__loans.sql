with source as (

    select * from {{ source('raw', 'loans') }}

),

renamed as (

    select
        customer_id,
        loan_id,
        cast(replace(loan_amount,',','.') as float) as loan_amount,
        loant_type,
        cast(replace(interest_rate,',','.') as float) as interest_rate,
        loan_term,
        cast(strptime(approval_rejection_date, '%d.%m.%Y')as date) as approval_rejection_date,
        loan_status

    from source
    where approval_rejection_date not like '%/%'

    union
    select
        customer_id,
        loan_id,
        cast(replace(loan_amount,',','.') as float) as loan_amount,
        loant_type,
        cast(replace(interest_rate,',','.') as float) as interest_rate,
        loan_term,
        cast(strptime(replace(approval_rejection_date, '/', '.'), '%m.%d.%Y') as date) as approval_rejection_date,
        loan_status

    from source
    where approval_rejection_date like '%/%'
)

select * from renamed