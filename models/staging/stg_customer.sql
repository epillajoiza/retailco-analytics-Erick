with source as (
    select * from {{ source('tpcds_raw', 'CUSTOMER') }}
),
renamed as (
    select
        cast(c_customer_sk as string) as customer_sk,
        c_customer_id as customer_id,
        cast(c_current_cdemo_sk as string) as current_cdemo_sk,
        cast(c_current_hdemo_sk as string) as current_hdemo_sk,
        cast(c_current_addr_sk as string) as current_addr_sk,
        cast(c_first_shipto_date_sk as string) as first_shipto_date_sk,
        cast(c_first_sales_date_sk as string) as first_sales_date_sk,
        c_salutation as salutation,
        coalesce(c_first_name, 'Desconocido') as first_name, 
        coalesce(c_last_name, 'Desconocido') as last_name,   
        c_preferred_cust_flag as preferred_cust_flag,
        c_birth_day as birth_day,
        c_birth_month as birth_month,
        c_birth_year as birth_year,
        c_birth_country as birth_country,
        c_login as login,
        c_email_address as email_address,
        c_last_review_date as last_review_date,
        year(current_date()) - c_birth_year as customer_age
    from source
)
select * from renamed
