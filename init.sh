#!/bin/bash

IMAGE_NAME="$1"
CONTAINER_NAME="$2"

# Check if Docker is running
check_docker() {
    if ! pgrep -x "Docker" > /dev/null
    then
        echo "Docker is not running. Attempting to start Docker..."
        
        # Try to start Docker
        open -a Docker

        # Wait until Docker starts (this may take a while)
        while ! pgrep -x "Docker" > /dev/null; do
            echo "Waiting for Docker to start..."
            sleep 2
        done

        echo "Docker has started."

    else
        echo "Docker is already running."
    fi
}

# Build the image
build_and_run_container() {
    echo "Image name: $IMAGE_NAME"
    echo "Container name: $CONTAINER_NAME"


    echo "Building the image ..."
    docker build -t "${IMAGE_NAME}:latest" .
    echo "Docker built '${IMAGE_NAME}' successfully."

    # Run the container
    echo "Starting the container ..."
    docker run -d  --name ${CONTAINER_NAME} -p 3000:3000 ${IMAGE_NAME}
    echo "Container '${CONTAINER_NAME}' is up and running."
}

#check_docker
build_and_run_container
