with stg_income_data as (
	select *
	from {{ source('income', 'income_age_and_sex') }}
)
select *
from stg_income_data
