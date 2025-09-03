-- Detect negative sum of amounts. The transaction amount should always be >= 0.
-- Therefore return records where sum_transaction_amount <= 0 to make the test fail.
select
    sum_transaction_amount
from {{ ref('stg_reporting__aggregate_transactions') }}
where sum_transaction_amount <= 0
