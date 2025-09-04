with source as (

    select * from {{ source('raw', 'customers') }}

),

renamed as (

    select
        customer_id,
        trim(firstname) as firstname,
        trim(lastname) as lastname,
        Age as 'age'

    from source

)

select 
    distinct * 
from renamed