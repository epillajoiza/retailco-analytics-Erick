with source as (
    select * from {{ source('tpcds_raw', 'ITEM') }}
),
renamed as (
    select
        cast(i_item_sk as string) as item_sk,
        i_item_id as item_id,
        i_item_desc as item_description,
        i_current_price as current_price,
        i_wholesale_cost as wholesale_cost,
        i_brand as brand_name,
        i_class as class_name,
        i_category as category_name,
        i_manufact as manufacturer_name,
        i_size as item_size,
        i_color as item_color,
        i_product_name as product_name,
        i_rec_start_date as valid_from,
        i_rec_end_date as valid_to,
        case 
            when i_rec_end_date is null then true 
            else false 
        end as is_current
    from source
)
select * from renamed
