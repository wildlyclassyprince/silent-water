FROM python:3.12-slim-bullseye

WORKDIR /silent-water
COPY ./requirements.txt .
COPY ./project ./project

# Virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install requirements
RUN pip install -U pip -r requirements.txt

# Setup dbt
RUN apt-get -y update && apt-get -y install git
RUN cd ./project/dwh/dbt && dbt clean && dbt deps && dbt compile --profiles-dir ./

WORKDIR /silent-water/project

# Use default port
EXPOSE 3000

# Run
ENTRYPOINT ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]
