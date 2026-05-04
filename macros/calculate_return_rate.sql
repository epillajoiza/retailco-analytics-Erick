{#
  Calculates the return rate percentage. Works for units and money.
  
  Params:
    - returned_metric: The returned value
    - sold_metric: The total sold value
    - scale: decimal places (default 2)

  Example:
    select {{ calculate_return_rate('sum(ret_qty)', 'sum(quantity)') }} as return_rate
#}

{% macro calculate_return_rate(returned_metric, sold_metric, scale=2) %}
    round(
        div0(
            coalesce({{ returned_metric }}, 0), 
            coalesce({{ sold_metric }}, 0)
        ) * 100, 
        {{ scale }}
    )
{% endmacro %}