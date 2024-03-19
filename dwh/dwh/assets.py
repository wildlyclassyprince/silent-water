import os
from pathlib import Path

import duckdb
import pandas as pd
import eurostat as eu

from dagster import asset, AssetExecutionContext, MetadataValue, MaterializeResult
from dagster_dbt import DbtCliResource, dbt_assets


@asset(compute_kind='python', group_name='income')
def income_age_and_sex(context: AssetExecutionContext) -> MaterializeResult:
    '''Raw Data: Mean and median income by age and sex.'''
    # Get data
    context.log.info('Querying data from EUROSTAT ...')
    toc_df = eu.get_toc_df()
    income_code = eu.subset_toc_df(toc_df, 'mean and median income by age and sex')['code'].iloc[0]
    income_dictionary = eu.get_dic(income_code)
    income_data = eu.get_data_df(income_code)

    # Insert
    with duckdb.connect('../dbt/test.duckdb') as con:
        con.sql('create schema if not exists income;')
        con.sql('create table if not exists income.income_age_and_sex as select * from income_data;')

    return MaterializeResult(
                metadata={
                        'num_records': len(income_data),
                        'code': income_code,
                        'dictionary': income_dictionary,
                        'preview': MetadataValue.md(income_data.head().to_markdown()),
                    }
            )

# dbt assets
dbt_project_dir = Path(__file__).joinpath('..', '..', '..', 'dbt').resolve()
dbt = DbtCliResource(project_dir=os.fspath(dbt_project_dir))

if os.getenv('DAGSTER_DBT_PARSE_PROJECT_ON_LOAD'):
    dbt_manifest_path = (
            dbt.cli(
               ['--quiet', 'parse'], 
                target_path=Path('target'),
             )
            .wait()
            .target_path.join_path('manifest.json')
        )
else:
    dbt_manifest_path = dbt_project_dir.joinpath('target', 'manifest.json')


@dbt_assets(manifest=dbt_manifest_path)
def dbt_assets(context: AssetExecutionContext):
    yield from dbt.cli(['build'], context=context).stream()

