select *

from {{ ref('stg_course_progress') }}

where lesson_completed > total_lessons