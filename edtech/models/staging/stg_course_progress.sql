{{ config(materialized='view') }}

select

    progress_id,
    student_id,
    course_id,
    lesson_completed,
    total_lessons,
    completion_percent,
    last_activity_date,
    trim(status) as status,
    created_at,
    updated_at

from {{ source('edtech','course_progress') }}