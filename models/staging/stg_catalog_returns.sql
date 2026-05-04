with source as (
    select * from {{ source('tpcds_raw', 'CATALOG_RETURNS') }}
),
renamed as (
    select
        cast(cr_order_number as string) as order_number,
        cast(cr_item_sk as string) as item_sk,
        cast(cr_refunded_customer_sk as string) as refunded_customer_sk,
        cast(cr_returning_customer_sk as string) as returning_customer_sk,
        cast(cr_returned_date_sk as string) as returned_date_sk,
        cast(cr_returned_time_sk as string) as returned_time_sk,
        cast(cr_call_center_sk as string) as call_center_sk,
        cast(cr_catalog_page_sk as string) as catalog_page_sk,
        cast(cr_ship_mode_sk as string) as ship_mode_sk,
        cast(cr_warehouse_sk as string) as warehouse_sk,
        cast(cr_reason_sk as string) as reason_sk,
        cr_return_quantity as return_quantity,
        cr_return_amount as return_amt,
        cr_return_tax as return_tax,
        cr_return_amt_inc_tax as return_amt_inc_tax,
        cr_fee as return_fee,
        cr_return_ship_cost as return_ship_cost,
        cr_refunded_cash as refunded_cash,
        cr_reversed_charge as reversed_charge,
        cr_store_credit as store_credit,
        cr_net_loss as net_loss
    from source
)
select * from renamed
