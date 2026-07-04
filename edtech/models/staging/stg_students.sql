{{ config(materialized='view') }}

select

    student_id,
    trim(first_name) as first_name,
    trim(last_name) as last_name,
    concat_ws(' ', trim(first_name), trim(last_name)) as student_name,
    LOWER(TRIM(email)) AS email,
    phone,
    RIGHT(REGEXP_REPLACE(SPLIT_PART(phone,'x',1), '[^0-9]',''), 10) as phone_number,
    gender,
    date_of_birth,
    trim(city) as city,
    trim(country) as country,
    registration_date,
    status  ,
    created_at,
    updated_at

from {{ source('edtech', 'students') }}
