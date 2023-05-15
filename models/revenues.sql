{{
  config(materialized='table')
}}

with revenue_data as (
    select
        sum(amount) as total_revenue
    from {{ ref('stg_payments') }}
)

select * from revenue_data