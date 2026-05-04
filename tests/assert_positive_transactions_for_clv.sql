select *
from {{ ref('mart_customer_lifetime_value') }}
where clv_net_revenue > 0 
  and total_transactions = 0
