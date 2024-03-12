import eurostat as eu
import duckdb

# Get data
print('getting the data from EUROSTAT ...')
toc_df = eu.get_toc_df()
income_code = eu.subset_toc_df(toc_df, 'mean and median income by age and sex')['code'].iloc[0]
income_dictionary = eu.get_dic(income_code)
income_data = eu.get_data_df(income_code)
print('Done')

# Insert
print('Inserting into duckdb ...')
with duckdb.connect('./test.duckdb') as con:
    con.sql('create schema income;')
    con.sql('create table income.income_age_and_sex as select * from income_data;')
    con.table('income.income_age_and_sex').show()
print('Done')

