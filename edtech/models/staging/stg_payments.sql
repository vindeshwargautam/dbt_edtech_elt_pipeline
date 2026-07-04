{{ config(materialized='view') }}

select

    payment_id,
    student_id,
    course_id,
    payment_date,
    payment_amount,
    trim(payment_method) as payment_method,
    trim(COALESCE(payment_status,'Unknown')) as payment,
    transaction_id,
    created_at,
    updated_at

from {{ source('edtech','payments') }}