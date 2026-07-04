{{ config(materialized='view') }}

select

    course_id,
    trim(course_name) as course_name,
    trim(category) as category,
    trim(difficulty_level) as difficulty_level,
    duration_hours,
    price,
    instructor_id,
    created_date,
    status,
    created_at,
    updated_at

from {{ source('edtech', 'courses') }}