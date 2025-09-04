{{
    config(
        materialized='table'
    )
}}

/*  Sums up all transactions in EUR (Euro) per customer, account, branch and date. 
 *  To simplify everything, the provided exchange rate table should be used for all dates. 
 *  I assume that the branch is the transaction_type.
 *  As a precaution, the configuration is set to 'table' as requested.
 */

-- preparation with delta of transaction and fx, Get the amount in Euro
WITH cte_preparation AS (
    SELECT 
        accounts.customer_id
        , transactions.account_id
        , transactions.transaction_id
        , transactions.transaction_type as branch
        , fx_rates.fx_rate_date
        , abs(transactions.transaction_date - fx_rates.fx_rate_date) as delta_trans_fx_date
        , transactions.transaction_amount / fx_rates.fx_rate as transaction_amount_eur
    FROM {{ ref("stg_intermediate__transactions") }} as transactions
    LEFT JOIN {{ ref("stg_intermediate__fx_rates") }} as fx_rates
        ON transactions.transaction_currency = fx_rates.currency_iso_code
    INNER JOIN {{ ref("stg_intermediate__accounts") }} as accounts
        ON transactions.account_id = accounts.account_id
    -- take only care of entries with fx_rate (1 entry is missing)
    WHERE fx_rates.fx_rate is not null

-- get the fx entry for the transaction
), cte_get_fx_entry AS (
    SELECT 
        customer_id
        , account_id
        , branch
        , fx_rate_date
        , transaction_amount_eur
    FROM cte_preparation
    QUALIFY row_number() OVER (PARTITION BY transaction_id ORDER BY delta_trans_fx_date, fx_rate_date ASC) = 1
)

-- get the sum per customer rounded to 2 digits after the comma, account, branch and date
SELECT 
    customer_id
    , account_id
    , branch
    , fx_rate_date
    , round(sum(transaction_amount_eur), 2) as total_transaction_amount_eur
FROM cte_get_fx_entry
GROUP by customer_id, account_id, branch, fx_rate_date
