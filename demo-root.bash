#!/usr/bin/env bash
set -e

IMAGE="container-security-demo"
HOST_DIR="$(pwd)/host-data"
OUTFILE="root.txt"

docker build -t "$IMAGE" .

# Clean slate so we can see the file being created
rm -f "$HOST_DIR/$OUTFILE"

echo "=== DEMO 1: root container writes a new file ==="
echo "Before (host):"
ls -la "$HOST_DIR"

docker run --rm \
  -v "$HOST_DIR:/mnt/host-data" \
  "$IMAGE" \
  sh -c "echo 'written by root container' > /mnt/host-data/$OUTFILE && echo 'WRITE SUCCEEDED' || echo 'WRITE FAILED'"

echo "--- After (host):"
ls -la "$HOST_DIR"
echo "--- Contents of $OUTFILE:"
cat "$HOST_DIR/$OUTFILE" 2>/dev/null || echo "(file not created)"