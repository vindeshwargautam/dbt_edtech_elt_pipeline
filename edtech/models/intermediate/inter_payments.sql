{{ config(materialized='view') }}

WITH payments AS (

    SELECT

        payment_id,
        student_id,
        course_id,
        payment_date,
        payment_amount,
        payment_method,
        payment_status,
        created_at,
        updated_at

    FROM {{ ref('stg_payments') }}

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
    p.payment_id,

    -- Foreign Keys
    p.student_id,
    p.course_id,
    c.instructor_id,

    -- Transaction Attributes
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    p.payment_status,

    -- Audit Columns
    p.created_at,
    p.updated_at

FROM payments p

INNER JOIN students s
    ON p.student_id = s.student_id

INNER JOIN courses c
    ON p.course_id = c.course_id
