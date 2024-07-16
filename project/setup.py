from setuptools import find_packages, setup

setup(
    name="project",
    packages=find_packages(exclude=["project_tests"]),
    install_requires=[
        "dagster",
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
