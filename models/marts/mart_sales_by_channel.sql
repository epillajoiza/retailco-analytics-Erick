{{ config(
    materialized='incremental',
    unique_key='sale_month_sk',
    incremental_strategy='merge'
) }}

with sales as (
    select 
        s.order_id,
        s.date_key,
        s.item_sk,
        s.location_sk,
        s.sales_channel,
        s.quantity,
        s.sales_price,
        s.discount_amount,
        (s.quantity * s.sales_price) as gross_revenue
    from {{ ref('int_unified_sales') }} s
),
returns as (
    select 
        order_id,
        item_sk,
        return_quantity,
        return_amt
    from {{ ref('int_unified_returns') }}
),
joined_data as (
    select 
        s.date_key,
        s.sales_channel,
        s.location_sk,
        s.item_sk,
        s.quantity,
        s.sales_price,
        s.discount_amount,
        s.gross_revenue,
        coalesce(r.return_quantity, 0) as return_quantity,
        coalesce(r.return_amt, 0) as return_amount 
    from sales s
    left join returns r 
        on s.order_id = r.order_id and s.item_sk = r.item_sk
),
dates as (
    select date_sk, month_of_year as month, year
    from {{ ref('stg_date_dim') }}
),
items as (
    select item_sk, category_name
    from {{ ref('stg_item') }}
),
stores as (
    select store_sk, store_name
    from {{ ref('stg_store') }}
),
aggregated as (
    select 
        j.sales_channel,
        coalesce(st.store_name, 'Online/Catalog') as location_name, 
        i.category_name,
        d.year,
        d.month,
        max(j.date_key) as max_date_key,
        sum(j.quantity) as total_units_sold,
        sum(j.return_quantity) as total_units_returned,
        sum(j.gross_revenue) as total_gross_revenue,
        sum(j.return_amount) as total_return_amount,
        sum(j.discount_amount) as total_discount_amount,
        sum(j.quantity * j.sales_price) as total_base_price
    from joined_data j
    left join dates d on j.date_key = d.date_sk
    left join items i on j.item_sk = i.item_sk
    left join stores st on j.location_sk = st.store_sk 
    {% if is_incremental() %}
    where j.date_key >= (select coalesce(max(max_date_key), '0') from {{ this }})
    {% endif %}
    group by 1, 2, 3, 4, 5
)
select 
    md5(cast(concat(
        coalesce(cast(sales_channel as string), ''), '-', 
        coalesce(cast(location_name as string), ''), '-', 
        coalesce(cast(category_name as string), ''), '-', 
        coalesce(cast(year as string), ''), '-', 
        coalesce(cast(month as string), '')
    ) as string)) as sale_month_sk,
    sales_channel,
    location_name, 
    category_name,
    year,
    month,
    max_date_key,
    total_units_sold,
    total_units_returned,
    total_gross_revenue,
    total_return_amount,
    (total_gross_revenue - total_return_amount) as net_revenue,
    {{ calculate_return_rate('total_units_returned', 'total_units_sold', 2) }} as return_rate_pct,
    case 
        when total_base_price > 0 then (total_discount_amount / total_base_price) * 100 
        else 0 
    end as avg_discount_pct
from aggregated