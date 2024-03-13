from setuptools import find_packages, setup

setup(
    name="dwh",
    packages=find_packages(exclude=["dwh_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
