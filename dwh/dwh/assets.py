import duckdb
import pandas as pd
import eurostat as eu

from dagster import asset, AssetExecutionContext, MetadataValue, MaterializeResult


@asset(compute_kind='python', group_name='income')
def raw_income_age_and_sex(context: AssetExecutionContext) -> MaterializeResult:
    '''Raw Data: Mean and median income by age and sex.'''
    # Get data
    context.log.info('Querying data from EUROSTAT ...')
    toc_df = eu.get_toc_df()
    income_code = eu.subset_toc_df(toc_df, 'mean and median income by age and sex')['code'].iloc[0]
    income_dictionary = eu.get_dic(income_code)
    income_data = eu.get_data_df(income_code)

    # Insert
    with duckdb.connect('../../test.duckdb') as con:
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

