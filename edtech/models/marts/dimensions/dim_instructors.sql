{{ config(
    materialized='incremental',
    unique_key='instructor_id',
    incremental_strategy='merge'
) }}

SELECT

    instructor_id,
    instructor_name,
    email,
    specialization,
    experience_years,
    CASE
        WHEN experience_years <= 2 THEN 'Junior'
        WHEN experience_years BETWEEN 3 AND 5 THEN 'Mid Level'
        ELSE 'Senior'
    END AS experience_level,
    hire_date,
    DATEDIFF( YEAR, hire_date, CURRENT_DATE) AS tenure_years,
    status,
    CASE
        WHEN status = 'Active' THEN TRUE
        ELSE FALSE
    END AS is_active,

    created_at,
    updated_at

FROM {{ ref('stg_instructors') }}

{% if is_incremental() %}

WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})

{% endif %}