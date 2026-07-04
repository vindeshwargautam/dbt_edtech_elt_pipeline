{{ config(
    materialized='incremental',
    unique_key='payment_id',
    incremental_strategy='merge'
    ) }}

SELECT

    -- Business Event Identifier
    payment_id,

    -- Dimension Keys
    student_id,
    course_id,
    instructor_id,

    -- Measures
    payment_amount,

    -- Event Attributes
    payment_method,
    payment_status,
    payment_date,
    created_at,
    updated_at

FROM {{ ref('inter_payments') }}

{% if is_incremental() %}

WHERE updated_at >(SELECT MAX(updated_at) FROM {{ this }})

{% endif %}