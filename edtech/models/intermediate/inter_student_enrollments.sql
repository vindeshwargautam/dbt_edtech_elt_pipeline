{{ config(materialized='view') }}

WITH enrollments AS (

    SELECT

        enrollment_id,
        student_id,
        course_id,
        enrollment_date,
        completion_status,
        created_at,
        updated_at

    FROM {{ ref('stg_enrollments') }}

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
    e.enrollment_id,

    -- Foreign Keys
    e.student_id,
    e.course_id,
    c.instructor_id,

    -- Transaction Attributes
    e.enrollment_date,
    e.completion_status,

    -- Audit Columns
    e.created_at,
    e.updated_at

FROM enrollments e

INNER JOIN students s
    ON e.student_id = s.student_id

INNER JOIN courses c
    ON e.course_id = c.course_id
