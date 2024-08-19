#!/bin/bash

IMAGE_NAME="$1"
CONTAINER_NAME="$2"

# Build the image
build_and_run_container() {
    echo "Image name: $IMAGE_NAME"
    echo "Container name: $CONTAINER_NAME"


    echo "Building the image ..."
    docker build -t "${IMAGE_NAME}:latest" .
    echo "Docker built '${IMAGE_NAME}' successfully."

    # Run the container
    echo "Starting the container ..."
    docker run -d  --name ${CONTAINER_NAME} -v ./project:/${CONTAINER_NAME}/project -p 3000:3000 ${IMAGE_NAME}
    echo "Container '${CONTAINER_NAME}' is up and running."
}

# Compile the dbt project before building the container
compile_dbt_project() {
    echo "Compiling dbt project ..."
    pushd ./project/dwh/dbt 
    dbt clean
    dbt deps
    dbt compile --profiles-dir ./
    popd
    echo "dbt project compiled successfully."
}

# Create a local virtual environment - the container will use a different one
create_local_virtual_environment() {
    echo "Creating Python virtual env ..."
    python -m venv venv && . venv/bin/activate
    echo "Installing requirements ..."
    pip install -U pip -r requirements.txt
    echo "Virtual environment created successfully."
}

create_virtual_environment
compile_dbt_project
build_and_run_container
