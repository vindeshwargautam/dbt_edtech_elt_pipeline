{{ config(
    materialized='incremental',
    unique_key='course_id',
    incremental_strategy='merge'
) }}

SELECT

    course_id,
    course_name,
    category,
    difficulty_level,
    duration_hours,
    CASE
        WHEN duration_hours < 10 THEN 'Short'
        WHEN duration_hours BETWEEN 10 AND 30 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category,
    price,
    CASE
        WHEN price = 0 THEN 'Free'
        ELSE 'Paid'
    END AS pricing_type,
    instructor_id,
    created_date,
    status,
    CASE
        WHEN status = 'Active' THEN TRUE
        ELSE FALSE
    END AS is_active,
    created_at,
    updated_at

FROM {{ ref('stg_courses') }}

{% if is_incremental() %}

WHERE updated_at >(SELECT MAX(updated_at)FROM {{ this }})

{% endif %}