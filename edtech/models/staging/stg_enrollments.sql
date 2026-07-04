{{ config(materialized='view') }}

select

    enrollment_id,
    student_id,
    course_id,
    enrollment_date,
    COALESCE(trim(completion_status),'Enrolled') as completion_status,
    created_at,
    updated_at 

from {{ source('edtech', 'enrollments') }}
