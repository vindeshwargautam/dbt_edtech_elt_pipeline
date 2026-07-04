{% snapshot snap_dim_instructors %}

{{
    config(

        target_schema='snapshots',

        unique_key='instructor_id',

        strategy='timestamp',

        updated_at='updated_at',

        invalidate_hard_deletes=true

    )
}}

SELECT *

FROM {{ ref('dim_instructors') }}

{% endsnapshot %}