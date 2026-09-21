#!/usr/bin/env bash

# Environment variables for the demo container and host directory.
IMAGE="container-security-demo" # name of the Docker image to use for the demo
HOST_DIR="$(pwd)/host-data" # directory on the host to be mounted into the container
OUTFILE="user.txt" # file to be written by the non-root container

# Clean slate for the output file on the host.
rm -f "$HOST_DIR/$OUTFILE"

echo "=== DEMO 2: non-root container, all capabilities dropped ==="
echo "Before (host):"
# List the contents of the host directory before running the container.
ls -la "$HOST_DIR"

# Run as a non-root user with all capabilities dropped, mount the host directory,
# and attempt to write to it.
docker run --rm \
  --user 1001:1001 \
  --cap-drop=ALL \
  -v "$HOST_DIR:/mnt/host-data" \
  "$IMAGE" \
  sh -c "echo 'written by non-root container' > /mnt/host-data/$OUTFILE && echo 'WRITE SUCCEEDED' || echo 'WRITE FAILED'"

echo "--- After (host):"
# List the contents of the host directory after running the container.
ls -la "$HOST_DIR"
echo "--- Contents of $OUTFILE:"
# Display the contents of the output file on the host.
cat "$HOST_DIR/$OUTFILE" 2>/dev/null || echo "(file not created)"