{% snapshot snap_dim_courses %}

{{
    config(

        target_schema='snapshots',

        unique_key='course_id',

        strategy='timestamp',

        updated_at='updated_at',

        invalidate_hard_deletes=true

    )
}}

SELECT *

FROM {{ ref('dim_courses') }}

{% endsnapshot %}