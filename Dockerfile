FROM python:3.12-slim-bullseye

WORKDIR /silent-water
COPY ./requirements.txt .

# Virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install requirements
RUN pip install -U pip -r requirements.txt

WORKDIR /silent-water/project

# Use default port
EXPOSE 3000

# Run
ENTRYPOINT ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]
