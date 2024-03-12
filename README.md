# silent-water

## Setup

Virtual environment:
```cmd
python3 -m venv venv
. venv/bin/activate
```

Install prerequisites:
```cmd
pip install -U pip -r requirements.txt
```

## Build

Extract data and create persistent database:
```cmd
python3 test.py
```

Run models:
```cmd
dbt run --profiles-dir ./
```
