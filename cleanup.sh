#!/bin/bash

# Stop the container
docker stop silent-water
if [ $? -ne 0 ]; then
    echo "Error: Failed to stop the container 'silent-water'."
    exit 1
fi

# Remove the container
docker rm silent-water
if [ $? -ne 0 ]; then
    echo "Error: Failed to remove the container 'silent-water'."
    exit 1
fi

echo "Container 'silent-water' stopped and removed successfully."
