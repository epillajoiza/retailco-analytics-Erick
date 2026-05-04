with source as (
    select * from {{ source('tpcds_raw', 'DATE_DIM') }}
),
renamed as (
    select
        cast(d_date_sk as string) as date_sk,
        d_date_id as date_id,
        d_date as date_day,
        d_year as year,
        d_moy as month_of_year,
        d_dom as day_of_month,
        d_dow as day_of_week,
        d_qoy as quarter_of_year,
        d_day_name as day_name,
        d_quarter_name as quarter_name,
        d_month_seq as month_seq,
        d_week_seq as week_seq,
        d_quarter_seq as quarter_seq,
        d_holiday as is_holiday,
        d_weekend as is_weekend,
        d_current_day as is_current_day,
        d_fy_year as fiscal_year,
        d_fy_quarter_seq as fiscal_quarter_seq,
        d_fy_week_seq as fiscal_week_seq
    from source
)
select * from renamed
