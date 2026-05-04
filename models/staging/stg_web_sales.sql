with source as (
    select * from {{ source('tpcds_raw', 'WEB_SALES') }}
),
renamed as (
    select
        cast(ws_sold_date_sk as string) as sold_date_sk,
        cast(ws_sold_time_sk as string) as sold_time_sk,
        cast(ws_ship_date_sk as string) as ship_date_sk,
        cast(ws_item_sk as string) as item_sk,
        cast(ws_bill_customer_sk as string) as bill_customer_sk,
        cast(ws_bill_cdemo_sk as string) as bill_cdemo_sk,
        cast(ws_bill_hdemo_sk as string) as bill_hdemo_sk,
        cast(ws_bill_addr_sk as string) as bill_addr_sk,
        cast(ws_ship_customer_sk as string) as ship_customer_sk,
        cast(ws_ship_cdemo_sk as string) as ship_cdemo_sk,
        cast(ws_ship_hdemo_sk as string) as ship_hdemo_sk,
        cast(ws_ship_addr_sk as string) as ship_addr_sk,
        cast(ws_web_page_sk as string) as web_page_sk,
        cast(ws_web_site_sk as string) as web_site_sk,
        cast(ws_ship_mode_sk as string) as ship_mode_sk,
        cast(ws_warehouse_sk as string) as warehouse_sk,
        cast(ws_promo_sk as string) as promo_sk,
        cast(ws_order_number as string) as order_number,
        ws_quantity as quantity,
        ws_wholesale_cost as wholesale_cost,
        ws_list_price as list_price,
        ws_sales_price as sales_price,
        ws_ext_discount_amt as ext_discount_amt,
        ws_ext_sales_price as ext_sales_price,
        ws_ext_wholesale_cost as ext_wholesale_cost,
        ws_ext_list_price as ext_list_price,
        ws_ext_tax as ext_tax,
        ws_coupon_amt as coupon_amt,
        ws_ext_ship_cost as ext_ship_cost,
        ws_net_paid as net_paid,
        ws_net_paid_inc_tax as net_paid_inc_tax,
        ws_net_paid_inc_ship as net_paid_inc_ship,
        ws_net_paid_inc_ship_tax as net_paid_inc_ship_tax,
        ws_net_profit as net_profit
    from source
)
select * from renamed
