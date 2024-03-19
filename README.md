# silent-water

This is a basic ELT proof of concept that reads from the Eurostats API and models data to provide insights about income across various demographics.

The orchestrator of choice is Dagster and uses Python to read data and metadata from the API, upload it to a local duckdb database, and perform data modeling using dbt.

# Setup

Execute the `run.sh` with the command:
```cmd
. run.sh
```

This script will:

- [x] Create and activate a virtual environment
- [x] Download requirements
- [x] Setup dbt
- [x] Run Dagster in dev mode 

Navigate to `http://localhost:3000` to access the Dagster UI and create the data assets by clicking on __Materialize All__.
