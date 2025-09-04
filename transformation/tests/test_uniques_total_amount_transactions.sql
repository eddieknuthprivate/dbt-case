/* Test the uniqueness of the columns customer_id, account_id, branch, 
 * fx_rate_date of the table stg_reporting__total_amount_transactions. 
 */

SELECT
    customer_id
    , account_id 
    , branch
    , fx_rate_date
    , count(*)
FROM {{ ref('stg_reporting__total_amount_transactions') }}
GROUP BY customer_id, account_id, branch, fx_rate_date
HAVING count(*) > 1
