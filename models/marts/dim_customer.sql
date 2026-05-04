{{ config(
    materialized='table'
) }}

with customer_enriched as (
    select * from {{ ref('int_customer_enriched') }}
)

select
    customer_sk as customer_key,
    first_name,
    last_name,
    city,
    state,
    gender,
    education_status as education,
    buy_potential
from customer_enriched