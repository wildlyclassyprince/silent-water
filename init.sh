#!/bin/bash

# Check if Docker is running
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

# Build the image
echo "Building the image ..."
docker build -t silent-water:latest .
echo "Docker built the image successfully."

# Run the container
echo "Starting the container ..."
docker run -d  --name silent-water silent-water:latest
echo "Container is up and running."
