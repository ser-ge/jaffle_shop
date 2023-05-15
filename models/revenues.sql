{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        p.payment_method,
        sum(p.amount) as revenue
    from orders o
    join payments p on o.order_id = p.order_id
    group by 1, 2, 3, 4, 5
)

select * from joined