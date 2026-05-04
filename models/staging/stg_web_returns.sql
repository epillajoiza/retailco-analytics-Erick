with source as (
    select * from {{ source('tpcds_raw', 'WEB_RETURNS') }}
),
renamed as (
    select
        cast(wr_order_number as string) as order_number,
        cast(wr_item_sk as string) as item_sk,
        cast(wr_refunded_customer_sk as string) as refunded_customer_sk,
        cast(wr_returning_customer_sk as string) as returning_customer_sk,
        cast(wr_returned_date_sk as string) as returned_date_sk,
        cast(wr_returned_time_sk as string) as returned_time_sk,
        cast(wr_web_page_sk as string) as web_page_sk,
        cast(wr_reason_sk as string) as reason_sk,
        wr_return_quantity as return_quantity,
        wr_return_amt as return_amt,
        wr_return_tax as return_tax,
        wr_return_amt_inc_tax as return_amt_inc_tax,
        wr_fee as return_fee,
        wr_return_ship_cost as return_ship_cost,
        wr_refunded_cash as refunded_cash,
        wr_reversed_charge as reversed_charge,
        wr_account_credit as account_credit,
        wr_net_loss as net_loss
    from source
)
select * from renamed
