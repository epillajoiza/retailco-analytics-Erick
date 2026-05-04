with source as (
    select * from {{ source('tpcds_raw', 'HOUSEHOLD_DEMOGRAPHICS') }}
),
renamed as (
    select
        cast(hd_demo_sk as string) as household_demo_sk,
        cast(hd_income_band_sk as string) as income_band_sk,
        hd_buy_potential as buy_potential,
        hd_dep_count as dependent_count,
        hd_vehicle_count as vehicle_count
    from source
)
select * from renamed
