{{ config(materialized='ephemeral') }}
with s_ret as (
    select 
        ticket_number as order_id,
        item_sk,
        'store' as return_channel,
        return_quantity, return_amt
    from {{ ref('stg_store_returns') }}
),
c_ret as (
    select 
        order_number as order_id,
        item_sk,
        'catalog' as return_channel,
        return_quantity, return_amt
    from {{ ref('stg_catalog_returns') }}
),
w_ret as (
    select 
        order_number as order_id,
        item_sk,
        'web' as return_channel,
        return_quantity, return_amt
    from {{ ref('stg_web_returns') }}
)
select * from s_ret union all select * from c_ret union all select * from w_ret
