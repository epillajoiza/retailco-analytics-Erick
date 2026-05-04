with source as (
    select * from {{ source('tpcds_raw', 'CATALOG_SALES') }}
),
renamed as (
    select
        cast(cs_sold_date_sk as string) as sold_date_sk,
        cast(cs_sold_time_sk as string) as sold_time_sk,
        cast(cs_ship_date_sk as string) as ship_date_sk,
        cast(cs_bill_customer_sk as string) as bill_customer_sk,
        cast(cs_bill_cdemo_sk as string) as bill_cdemo_sk,
        cast(cs_bill_hdemo_sk as string) as bill_hdemo_sk,
        cast(cs_bill_addr_sk as string) as bill_addr_sk,
        cast(cs_ship_customer_sk as string) as ship_customer_sk,
        cast(cs_ship_cdemo_sk as string) as ship_cdemo_sk,
        cast(cs_ship_hdemo_sk as string) as ship_hdemo_sk,
        cast(cs_ship_addr_sk as string) as ship_addr_sk,
        cast(cs_call_center_sk as string) as call_center_sk,
        cast(cs_catalog_page_sk as string) as catalog_page_sk,
        cast(cs_ship_mode_sk as string) as ship_mode_sk,
        cast(cs_warehouse_sk as string) as warehouse_sk,
        cast(cs_item_sk as string) as item_sk,
        cast(cs_promo_sk as string) as promo_sk,
        cast(cs_order_number as string) as order_number,
        cs_quantity as quantity,
        cs_wholesale_cost as wholesale_cost,
        cs_list_price as list_price,
        cs_sales_price as sales_price,
        cs_ext_discount_amt as ext_discount_amt,
        cs_ext_sales_price as ext_sales_price,
        cs_ext_wholesale_cost as ext_wholesale_cost,
        cs_ext_list_price as ext_list_price,
        cs_ext_tax as ext_tax,
        cs_coupon_amt as coupon_amt,
        cs_ext_ship_cost as ext_ship_cost,
        cs_net_paid as net_paid,
        cs_net_paid_inc_tax as net_paid_inc_tax,
        cs_net_paid_inc_ship as net_paid_inc_ship,
        cs_net_paid_inc_ship_tax as net_paid_inc_ship_tax,
        cs_net_profit as net_profit
    from source
)
select * from renamed
