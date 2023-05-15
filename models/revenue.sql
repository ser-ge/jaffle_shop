{{
    config(materialized='table')
}}

with sum_amount as (
    select
        order_id,
        sum(amount) as total_amount
    from {{ ref('stg_payments') }}
    group by order_id
)

select * from sum_amount
