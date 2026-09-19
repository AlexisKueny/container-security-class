# Demo setup
mkdir -p ~/bind-demo && cd ~/bind-demo # <- create a directory in root
ls -ln

# Step 1: Bind/mount root file inside a docker container
docker run --rm alpine id # <- create the container for the demo using the alpine image, a tiny Linux distribution for our demo
docker run --rm -v ~/bind-demo:/data alpine ls -la /data # <- mount the local root directory into the container and list its contents

# Step 2: Create a file inside our mounted directory with root priveleges
docker run --rm -v ~/bind-demo:/data alpine \
  sh -c 'echo "Top Secret" > /data/root-file.txt' # <- create a simple text file with root privileges inside the container
cat ~/bind-demo/root-file.txt # <- display the contents of the file created by the container root

# Step 3: Attempt to edit the file as a non-root user
docker run --rm --user 1000:1000 --cap-drop=ALL -v ~/bind-demo:/data alpine \
  sh -c 'echo "try" > /data/root-file.txt' # <- attempt to create a file as a non-root user with all caps dropped
# Permission denied