with source as (
    select * from {{ source('tpcds_raw', 'STORE_RETURNS') }}
),
renamed as (
    select
        cast(sr_ticket_number as string) as ticket_number,
        cast(sr_item_sk as string) as item_sk,
        cast(sr_returned_date_sk as string) as returned_date_sk,
        cast(sr_return_time_sk as string) as return_time_sk,
        cast(sr_customer_sk as string) as customer_sk,
        cast(sr_cdemo_sk as string) as cdemo_sk,
        cast(sr_hdemo_sk as string) as hdemo_sk,
        cast(sr_addr_sk as string) as addr_sk,
        cast(sr_store_sk as string) as store_sk,
        cast(sr_reason_sk as string) as reason_sk,
        sr_return_quantity as return_quantity,
        sr_return_amt as return_amt,
        sr_return_tax as return_tax,
        sr_return_amt_inc_tax as return_amt_inc_tax,
        sr_fee as return_fee,
        sr_return_ship_cost as return_ship_cost,
        sr_refunded_cash as refunded_cash,
        sr_reversed_charge as reversed_charge,
        sr_store_credit as store_credit,
        sr_net_loss as net_loss
    from source
)
select * from renamed
