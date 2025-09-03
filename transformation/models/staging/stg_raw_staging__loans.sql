with source as (

    select * from {{ source('raw', 'loans') }}

),

renamed as (

    select
        customer_id,
        loan_id,
        loan_amount,
        loant_type,
        interest_rate,
        loan_term,
        strptime(approval_rejection_date, '%d.%m.%Y') as approval_rejection_date,
        loan_status

    from source
    where approval_rejection_date not like '%/%'

    union
    select
        customer_id,
        loan_id,
        loan_amount,
        loant_type,
        interest_rate,
        loan_term,
        strptime(replace(approval_rejection_date, '/', '.'), '%m.%d.%Y') as approval_rejection_date,
        loan_status

    from source
    where approval_rejection_date like '%/%'
)

select * from renamed