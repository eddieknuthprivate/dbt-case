/*  Sums up all transactions in EUR (Euro) per customer, account, branch and date. 
 *  To simplify everything, the provided exchange rate table should be used for all dates. 
 */

select 
    accounts.customer_id
    , transactions.account_id
    , transactions.transaction_type
    , sum(fx_rates.fx_rate * transactions.transaction_amount) as sum_transaction_amount
    , transactions.transaction_currency
from {{ ref("stg_intermediate__transactions") }} as transactions
inner join {{ ref("stg_intermediate__fx_rates") }} as fx_rates
    on transactions.transaction_currency = fx_rates.currency_iso_code
inner join {{ ref("stg_intermediate__accounts") }} as accounts
    on transactions.account_id = accounts.account_id
group by accounts.customer_id,transactions.account_id, transactions.transaction_type, transactions.transaction_currency
