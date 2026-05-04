with source as (
    select * from {{ source('tpcds_raw', 'CUSTOMER_DEMOGRAPHICS') }}
),
renamed as (
    select
        cast(cd_demo_sk as string) as demo_sk,
        cd_gender as gender,
        cd_marital_status as marital_status,
        cd_education_status as education_status,
        cd_purchase_estimate as purchase_estimate,
        cd_credit_rating as credit_rating,
        cd_dep_count as dependent_count,
        cd_dep_employed_count as dependent_employed_count,
        cd_dep_college_count as dependent_college_count
    from source
)
select * from renamed
