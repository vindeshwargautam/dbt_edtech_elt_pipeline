{{ config(materialized='view') }}

select

    instructor_id,
    trim(instructor_name) as instructor_name,
    lower(email) as email,
    trim(specialization) as specialization,
    experience_years,
    hire_date,
    status,
    created_at ,
    updated_at 

from {{ source('edtech', 'instructors') }}