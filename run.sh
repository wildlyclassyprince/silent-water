#! /bin/bash
# Create a virtual environment and download requirements
echo "Creating virtual environment in $PWD"
python3 -m venv venv && . venv/bin/activate

echo "Installing requirements ..."
pip install -U pip -r requirements.txt
echo "DONE"

# Setup dbt project
echo "Setting up dbt project ..."
pushd ./project/dwh/dbt
dbt clean && dbt deps && dbt compile --profiles-dir ./
popd
echo "DONE"

# Run Dagster ...
echo "Starting Dagster ..."
pushd ./project
dagster dev
