# Case Study at Varengold Bank AG - Data Engineering

## Introduction
This file contains the exploration of the case study of the given data.

[Contact me](mailto:eddie.knuth@t-online.de)

## Case Study

- customers entity:
  The unique check of the model staging.stg_raw_staging__customers shows 5000 results. 50 percent!

  select count(distinct customer_id),count(*) from staging.stg_raw_staging__customers;
  --> 5000 and 10000
  I have added 3 new 'not null' checks and comments.

- account entity:
  There is a problem with the date account_opening_date. I replaced empty strings with null values.

  I have added 2 new 'not null' checks and comments.

- fx_rates entity:
  I the table stg_raw_staging__fx_rates the data types of the columns fx_rate and fx_rate_date seems to be wrong. I changed them. 
  In addition I have added 2 new 'not null' checks and comments for the columns.
  Ichanged the data type for stg_reporting__aggregate_transactions from varchar to float.

- loans entity:
  The format in column of raw.loans is mixed. There are '/' and '.' in the date strings. My solution is to replace the '/' and also to take care of the different positions of months and days.
  I have detected that one ntry has a missing loan type. For the rest of the columns I have added 'not null' tests. In addition I have added a value check for the column loan_status. 
  I have added column descriptions. I changed the data type for loan_amount to float, interest_rate to float, approval_rejection_date to date.

- transaction entity:
  I have added new 'not null' tests, a foreign_key to the account entity and comments.
  I changed the foreign constraint to the new model currencies.

- currency entity:
  I loaded the csv file into the database with seed.
  There's another delimiter ';' instead of ',' (e.g. in dbt_project_evaluator_exceptions.csv). I added a seed entry in the dbt_project.yml file to take care of it.

  I think the iso_code should be the primary key in this table. There are a lot of entries that violate the primary key. In addition the value 'none' should be replaced 
  with a normal value.

  select currency_iso_code,count(*) from main.currencies group by currency_iso_code having count(*)>1;
  --> (none)=12 and USD=2

- One suggestion for an improvement for other studies is to pay attention to the libraries for Macbook users. With duckdb, I got an error at the beginning.
