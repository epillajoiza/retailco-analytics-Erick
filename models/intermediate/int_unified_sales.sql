{{ config(materialized='ephemeral') }}

with store as (
    select 
        ticket_number as order_id,
        sold_date_sk as date_key, 
        item_sk,
        customer_sk,
        store_sk as location_sk,  
        'store' as sales_channel,
        quantity, 
        sales_price, 
        ext_discount_amt as discount_amount,
        net_profit
    from {{ ref('stg_store_sales') }}
),
catalog as (
    select 
        order_number as order_id,
        sold_date_sk as date_key, 
        item_sk,
        bill_customer_sk as customer_sk, 
        call_center_sk as location_sk,   
        'catalog' as sales_channel,
        quantity, 
        sales_price, 
        ext_discount_amt as discount_amount,
        net_profit
    from {{ ref('stg_catalog_sales') }}
),
web as (
    select 
        order_number as order_id,
        sold_date_sk as date_key, 
        item_sk,
        bill_customer_sk as customer_sk, 
        web_site_sk as location_sk,      
        'web' as sales_channel,
        quantity, 
        sales_price, 
        ext_discount_amt as discount_amount,
        net_profit
    from {{ ref('stg_web_sales') }}
)

select * from store
union all
select * from catalog
union all
select * from web