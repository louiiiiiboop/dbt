-- Return customers with impossible order counts or inconsistent order dates.
-- Customers without orders should retain null dates and lifetime value.
select
    customer_id,
    number_of_orders,
    first_order_date,
    most_recent_order_date,
    lifetime_value
from {{ ref('dim_customer') }}
where number_of_orders < 0
    or first_order_date > most_recent_order_date
    or (
        number_of_orders = 0
        and (
            first_order_date is not null
            or most_recent_order_date is not null
            or lifetime_value is not null
        )
    )
