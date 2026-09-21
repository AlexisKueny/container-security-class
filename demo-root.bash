#!/usr/bin/env bash

# Environment variables for the demo container and host directory.
IMAGE="container-security-demo" # name of the Docker image to use for the demo
HOST_DIR="$(pwd)/host-data" # directory on the host to be mounted into the container
OUTFILE="root.txt" # File to be written by the root container

# Initial build for the docker image
docker build -t "$IMAGE" .

# Clean slate so we can see the file being created
rm -f "$HOST_DIR/$OUTFILE"

echo "=== DEMO 1: root container writes a new file ==="
echo "Before (host):"
# List the contents of the host directory before running the container.
ls -la "$HOST_DIR"

docker run --rm \
  # Mount the host directory into the container.
  -v "$HOST_DIR:/mnt/host-data" \
  # Specify the image to use.
  "$IMAGE" \
  # Attempt to write to the mounted host directory as the root user.
  sh -c "echo 'written by root container' > /mnt/host-data/$OUTFILE && echo 'WRITE SUCCEEDED' || echo 'WRITE FAILED'"

echo "--- After (host):"
# List the contents of the host directory after running the container.
ls -la "$HOST_DIR"
echo "--- Contents of $OUTFILE:"
# Display the contents of the output file on the host.
cat "$HOST_DIR/$OUTFILE" 2>/dev/null || echo "(file not created)"