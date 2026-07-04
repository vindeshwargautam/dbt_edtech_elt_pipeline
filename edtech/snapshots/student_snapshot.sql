{% snapshot snap_dim_students %}

{{
    config(

        target_schema='snapshots',

        unique_key='student_id',

        strategy='timestamp',

        updated_at='updated_at',

        invalidate_hard_deletes=true

    )
}}

SELECT *

FROM {{ ref('dim_students') }}

{% endsnapshot %}