# Case Study at Varengold Bank AG - Data Engineering

## Introduction
This file contains notes on the case study investigation. It is based on data from ducktdb.

[Contact me](mailto:eddie.knuth@t-online.de)

* * *
## Case Study
I found a lot of things in the given data and structure. Here are the main points per entity.

- customers entity:
  The unique check of the model staging.stg_raw_staging__customers shows 5000 results. I use a distinct to avoid the double entries.

  select count(distinct customer_id),count(*) from staging.stg_raw_staging__customers;
  --> 5000 and 10000

  I have added 3 new 'not null' checks and comments.

- account entity:
  There is a problem with the date account_opening_date. I replaced empty strings with null values.

  I have added 2 new 'not null' checks and comments.

  There's one entry with an empty string which is detected by a new automatic test.

- fx_rates entity:
  In the model stg_raw_staging__fx_rates the data types of the columns fx_rate and fx_rate_date seems to be wrong. I changed them. 
  In addition I have added 2 new 'not null' checks and comments for the columns.
  I changed the data type for stg_reporting__aggregate_transactions from varchar to float and fx_rate_date to date.

- loans entity:
  The format in column of raw.loans is mixed. There are '/' and '.' in the date strings. My solution is to replace the '/' and also to take care of the different positions of months and days.
  I have detected that one entry has a missing loan type. For the rest of the columns I have added 'not null' tests. In addition I have added a value check for the column loan_status. 
  I have added column descriptions. I changed the data type for loan_amount to float, interest_rate to float, approval_rejection_date to date.
  The name of loant_type is changed to loan_type.

- transaction entity:
  I have added new 'not null' tests, a foreign_key to the account entity and comments.
  I changed the foreign constraint to the new model currencies.

- currency entity:
  I loaded the csv file into the database with seed.
  There's another delimiter ';' instead of ',' (e.g. in dbt_project_evaluator_exceptions.csv). So I had take care of it.

  The iso_code is the primary key of this table. There are entries that violate the primary key. In addition the value 'none' should be replaced 
  with a normal value (not part of this study).

  select currency_iso_code, count(*) from main.currencies group by currency_iso_code having count()>1;
  --> (none)=12 and USD=2

  All models with usage of the iso currency code use thius model in their constraints.

## Final note
One suggestion for an improvement for other studies is to pay attention to the libraries for Macbook users. With duckdb, I got an error at the beginning.
I have added the new automatic tests to both the staging and intermediate layer. Better safe than sorry. Only the singular tests (own sql file) are not implemented on the staging layer.
