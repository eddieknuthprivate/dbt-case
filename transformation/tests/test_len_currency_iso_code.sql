-- Detect currency_iso_code which length are different to 3.
select
    currency_iso_code
    , count(*)
from {{ ref('stg_intermediate__currencies') }}
where length(currency_iso_code) != 3 
group by currency_iso_code
