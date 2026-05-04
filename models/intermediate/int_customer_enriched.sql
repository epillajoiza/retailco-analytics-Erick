{{ config(materialized='ephemeral') }}
select 
    c.customer_sk,
    c.first_name,
    c.last_name,
    a.city,
    a.state,
    cd.gender,
    cd.marital_status,
    cd.education_status,
    hd.buy_potential,
    hd.vehicle_count
from {{ ref('stg_customer') }} c
left join {{ ref('stg_customer_address') }} a on c.current_addr_sk = a.address_sk
left join {{ ref('stg_customer_demographics') }} cd on c.current_cdemo_sk = cd.demo_sk
left join {{ ref('stg_household_demographics') }} hd on c.current_hdemo_sk = hd.household_demo_sk
