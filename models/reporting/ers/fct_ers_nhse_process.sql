{{ config(tags=['ers', 'large_periodic']) }}

with request_triage as (
    select 
        sk_patient_id
        ubrn_id,
        ubrn,
        action_at,
        row_number() over(partition by ubrn order by action_id) as action_sequence,
        action_code
    from {{ ref('fct_ers_referral_action') }}
)

select *
from request_triage
