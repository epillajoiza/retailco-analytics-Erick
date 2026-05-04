with source as (
    select * from {{ source('tpcds_raw', 'STORE_SALES') }}
),
renamed as (
    select
        cast(ss_sold_date_sk as string) as sold_date_sk,
        cast(ss_sold_time_sk as string) as sold_time_sk,
        cast(ss_item_sk as string) as item_sk,
        cast(ss_customer_sk as string) as customer_sk,
        cast(ss_cdemo_sk as string) as cdemo_sk,
        cast(ss_hdemo_sk as string) as hdemo_sk,
        cast(ss_addr_sk as string) as addr_sk,
        cast(ss_store_sk as string) as store_sk,
        cast(ss_promo_sk as string) as promo_sk,
        cast(ss_ticket_number as string) as ticket_number,
        ss_quantity as quantity,
        ss_wholesale_cost as wholesale_cost,
        ss_list_price as list_price,
        ss_sales_price as sales_price,
        ss_ext_discount_amt as ext_discount_amt,
        ss_ext_sales_price as ext_sales_price,
        ss_ext_wholesale_cost as ext_wholesale_cost,
        ss_ext_list_price as ext_list_price,
        ss_ext_tax as ext_tax,
        ss_coupon_amt as coupon_amt,
        ss_net_paid as net_paid,
        ss_net_paid_inc_tax as net_paid_inc_tax,
        ss_net_profit as net_profit
    from source
)
select * from renamed