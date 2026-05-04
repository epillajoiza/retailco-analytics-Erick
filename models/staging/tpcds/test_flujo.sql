with source as (
    select * from {{ source('tpcds_raw', 'DATE_DIM') }}
),
renamed as (
    select
        D_DATE_SK as date_key,
        D_DATE as date_day,
        D_YEAR as year
    from source
)
select * from renamed
