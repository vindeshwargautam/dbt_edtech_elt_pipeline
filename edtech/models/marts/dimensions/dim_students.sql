{{ config(
    materialized='incremental',
    unique_key='student_id',
    incremental_strategy='merge'
) }}

SELECT

    student_id,
    student_name,
    email,
    phone_number,
    gender,
    date_of_birth,
    DATEDIFF(YEAR, date_of_birth,CURRENT_DATE) AS student_age,
    CASE
        WHEN DATEDIFF(YEAR, date_of_birth, CURRENT_DATE) < 18
            THEN 'Teen'
        WHEN DATEDIFF(YEAR, date_of_birth, CURRENT_DATE) BETWEEN 18 AND 25
            THEN 'Young Adult'
        ELSE 'Adult'
    END AS age_group,
    city,
    country,
    CASE
        WHEN country = 'India'
            THEN 'Domestic'
        ELSE 'International'
    END AS student_type,
    registration_date,
    status,
    CASE
        WHEN status = 'Active'
            THEN TRUE
        ELSE FALSE
    END AS is_active,
    created_at,
    updated_at

FROM {{ ref('stg_students') }}

{% if is_incremental() %}

WHERE updated_at >(SELECT MAX(updated_at) FROM {{ this }})

{% endif %}

