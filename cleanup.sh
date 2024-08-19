#!/bin/bash

CONTAINER_NAME="$1"

# Ensure variables are set
if [ -z "$CONTAINER_NAME" ]; then
    echo "Error: CONTAINER_NAME is not set."
    exit 1
else
    echo "Stopping $CONTAINER_NAME ..."
fi

# Stop the container
docker stop ${CONTAINER_NAME}
if [ $? -ne 0 ]; then
    echo "Error: Failed to stop the container 'silent-water'."
    exit 1
fi

# Remove the container
docker rm ${CONTAINER_NAME}
if [ $? -ne 0 ]; then
    echo "Error: Failed to remove the container '${CONTAINER_NAME}'."
    exit 1
fi

echo "Container '${CONTAINER_NAME}' stopped and removed successfully."
