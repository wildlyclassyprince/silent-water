with source as (
	{#-
		Use source instead of seed:
	#}
	select * from {{ source('income', 'income_age_and_sex')}}

),

renamed as (
	select *
	from source
)
select *
from renamed
