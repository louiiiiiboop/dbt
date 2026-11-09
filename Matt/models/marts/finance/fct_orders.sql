with 

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),
payments as (

    select * from {{ ref("stg_stripe__payments") }}
    )

,

customer_orders as (

    select
        customer_id,
        orders.order_id,
        amount

    from orders
    left join payments on orders.order_id=payments.order_id

)




select * from customer_orders