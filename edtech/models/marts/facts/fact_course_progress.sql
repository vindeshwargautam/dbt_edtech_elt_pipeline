{{ config(
    materialized='incremental',
    unique_key='progress_id',
    incremental_strategy='merge'
) }}

SELECT

    -- Business Event Identifier
    Progress_id,

    -- Dimension Keys
    student_id,
    course_id,
    instructor_id,

    -- Event Attributes
    completion_percent,
    last_activity_date,

    created_at,
    updated_at

FROM {{ ref('inter_course_progress') }}

{% if is_incremental() %}

WHERE updated_at >(SELECT MAX(updated_at) FROM {{ this }})

{% endif %}