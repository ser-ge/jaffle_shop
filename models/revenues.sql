{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

revenues as (
    select
        orders.order_id,
        sum(payments.amount) as total_revenue
    from orders
    join payments
        on orders.order_id = payments.order_id
    group by orders.order_id
)

select * from revenues
