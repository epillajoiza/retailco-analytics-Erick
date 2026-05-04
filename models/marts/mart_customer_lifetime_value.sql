{{ config(
    materialized='table'
) }}
with sales as (
    select * from {{ ref('int_unified_sales') }}
),
returns as (
    select * from {{ ref('int_unified_returns') }}
),
customer_sales as (
    select 
        customer_sk,
        count(distinct order_id) as total_transactions,
        count(distinct sales_channel) as channels_used,
        min(date_key) as first_purchase_date, 
        max(date_key) as last_purchase_date,  
        sum(quantity) as total_qty_bought,
        sum(quantity * sales_price) as gross_revenue
    from sales
    where customer_sk is not null
    group by 1
),
customer_returns as (
    select 
        s.customer_sk,
        sum(r.return_quantity) as total_qty_returned,
        sum(r.return_amt) as total_amt_returned
    from returns r
    inner join sales s on r.order_id = s.order_id and r.item_sk = s.item_sk
    group by 1
),
clv_base as (
    select 
        s.customer_sk,
        s.total_transactions,
        s.channels_used,
        s.first_purchase_date as first_purchase,
        s.last_purchase_date as last_purchase,
        s.gross_revenue - coalesce(r.total_amt_returned, 0) as clv_net_revenue,
        {{ calculate_return_rate('r.total_qty_returned', 's.total_qty_bought', 2) }} as return_rate_pct
    from customer_sales s
    left join customer_returns r on s.customer_sk = r.customer_sk
),
segmentation as (
    select 
        *,
        ntile(3) over (order by clv_net_revenue desc) as clv_percentile
    from clv_base
)
select 
    c.customer_key,
    c.first_name,
    c.last_name,
    s.total_transactions,
    s.channels_used,
    s.first_purchase,
    s.last_purchase,
    s.clv_net_revenue,
    s.return_rate_pct,
    case 
        when clv_percentile = 1 then 'Alto'
        when clv_percentile = 2 then 'Medio'
        when clv_percentile = 3 then 'Bajo'
    end as value_segment
from segmentation s
left join {{ ref('dim_customer') }} c on s.customer_sk = c.customer_key
