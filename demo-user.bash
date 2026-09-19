#!/usr/bin/env bash
set -e

IMAGE="container-security-demo"
HOST_DIR="$(pwd)/host-data"
OUTFILE="user.txt"

rm -f "$HOST_DIR/$OUTFILE"

echo "=== DEMO 2: non-root container, all capabilities dropped ==="
echo "Before (host):"
ls -la "$HOST_DIR"

docker run --rm \
  --user 1001:1001 \
  --cap-drop=ALL \
  -v "$HOST_DIR:/mnt/host-data" \
  "$IMAGE" \
  sh -c "echo 'written by non-root container' > /mnt/host-data/$OUTFILE && echo 'WRITE SUCCEEDED' || echo 'WRITE FAILED'"

echo "--- After (host):"
ls -la "$HOST_DIR"
echo "--- Contents of $OUTFILE:"
cat "$HOST_DIR/$OUTFILE" 2>/dev/null || echo "(file not created)"