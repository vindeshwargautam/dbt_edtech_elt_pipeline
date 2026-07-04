{{ config(materialized='view') }}

WITH course_progress AS (

    SELECT

        progress_id,
        student_id,
        course_id,
        completion_percent,
        last_activity_date,
        created_at,
        updated_at

    FROM {{ ref('stg_course_progress') }}

),

students AS (

    SELECT

        student_id

    FROM {{ ref('stg_students') }}

),

courses AS (

    SELECT

        course_id,
        instructor_id
    

    FROM {{ ref('stg_courses') }}

)

SELECT

    -- Primary Key
    cp.progress_id,

    -- Foreign Keys
    s.student_id,
    cp.course_id,
    c.instructor_id,

    -- Progress Details
    cp.completion_percent,
    cp.last_activity_date,

    -- Audit Columns
    cp.created_at,
    cp.updated_at

FROM course_progress cp

INNER JOIN students s
    ON cp.student_id = s.student_id

INNER JOIN courses c
    ON cp.course_id = c.course_id

