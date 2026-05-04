{{ config(
    materialized='table'
) }}
with sales as (
    select 
        item_sk, 
        date_key, 
        quantity 
    from {{ ref('int_unified_sales') }}
),
sales_with_week as (
    select 
        s.item_sk,
        d.week_seq, 
        sum(s.quantity) as weekly_sales
    from sales s
    join {{ ref('stg_date_dim') }} d on s.date_key = d.date_sk
    group by 1, 2
),
avg_sales as (
    select 
        item_sk,
        avg(weekly_sales) as avg_weekly_sales
    from sales_with_week
    group by 1
),
inventory as (
    select 
        inv_item_sk as item_sk,
        inv_date_sk as date_sk,
        inv_quantity_on_hand as stock
    from {{ source('tpcds_raw', 'INVENTORY') }}
),
inventory_weekly as (
    select 
        i.item_sk,
        d.week_seq,
        avg(i.stock) as avg_weekly_stock,
        min(i.stock) as min_stock 
    from inventory i
    join {{ ref('stg_date_dim') }} d on i.date_sk = d.date_sk
    group by 1, 2
),
inventory_health as (
    select 
        iw.item_sk,
        iw.week_seq,
        iw.avg_weekly_stock,
        coalesce(asales.avg_weekly_sales, 0) as avg_weekly_sales,
        div0(iw.avg_weekly_stock, coalesce(asales.avg_weekly_sales, 0)) as weeks_of_stock,
        case when iw.min_stock <= 0 then 1 else 0 end as is_stockout_week,
        lag(iw.avg_weekly_stock) over (partition by iw.item_sk order by iw.week_seq) as prev_weekly_stock
    from inventory_weekly iw
    left join avg_sales asales on iw.item_sk = asales.item_sk
)
select 
    item_sk as item_key,
    week_seq as week_id,
    avg_weekly_stock,
    weeks_of_stock,
    is_stockout_week,
    case 
        when prev_weekly_stock is null then 'estable'
        when avg_weekly_stock > prev_weekly_stock then 'creciente'
        when avg_weekly_stock < prev_weekly_stock then 'decreciente'
        else 'estable'
    end as stock_trend
from inventory_health
