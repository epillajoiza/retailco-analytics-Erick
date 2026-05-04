select *
from {{ ref('mart_sales_by_channel') }}
where return_rate_pct > 100 or return_rate_pct < 0
