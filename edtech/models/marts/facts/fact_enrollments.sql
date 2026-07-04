{{ config(
    materialized='incremental',
    unique_key='enrollment_id',
    incremental_strategy='merge'
) }}

SELECT

    -- Business Event Identifier
    enrollment_id,

    -- Dimension Keys
    student_id,
    course_id,
    instructor_id,

    -- Event Attributes
    enrollment_date,
    completion_status,

    created_at,
    updated_at

FROM {{ ref('inter_student_enrollments') }}

{% if is_incremental() %}

WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})

{% endif %}