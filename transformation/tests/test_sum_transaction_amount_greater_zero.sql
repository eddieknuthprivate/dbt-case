-- Detect negative sum of amounts. The transaction amount should always be >= 0.
-- Therefore return records where total_transaction_amount_eur <= 0 to make the test fail.
select
    total_transaction_amount_eur
from {{ ref('stg_reporting__aggregate_transactions') }}
where total_transaction_amount_eur <= 0
