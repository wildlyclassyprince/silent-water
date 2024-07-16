import os 

from pathlib import Path
from dagster import AssetExecutionContext, MetadataValue
from dagster_dbt import DbtCliResource, dbt_assets, DagsterDbtTranslator
from typing import Any, Mapping

# dbt assets
dbt_project_dir = Path(__file__).joinpath('..', '..', 'dbt').resolve()
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


class CustomDagsterDbtTranslator(DagsterDbtTranslator):
    def get_metadata(self, dbt_resource_props: Mapping[str, Any]) -> Mapping[str, Any]:
        return {
            "dbt_metadata": MetadataValue.json(dbt_resource_props.get("meta", {}))
        }

@dbt_assets(manifest=dbt_manifest_path, dagster_dbt_translator=CustomDagsterDbtTranslator(),)
def dbt_assets(context: AssetExecutionContext):
    yield from dbt.cli(['build'], context=context).stream()
