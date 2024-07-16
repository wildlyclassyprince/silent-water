from dagster import Definitions

from .raw.assets import income_age_and_sex
from .modelling.assets import dbt_assets

defs = Definitions(
    assets=[income_age_and_sex, dbt_assets,]
)
