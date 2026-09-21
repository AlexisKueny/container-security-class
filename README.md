# How to understand this repository
This repository contains my research and the scripts used for the demo. As I am on windows, the demo will be run from inside WSL

## Project structure

```text
container-security-demo/
├── Dockerfile
├── demo-root.sh
├── demo-nonroot.sh
└── host-data/    ← bind-mounted directory where demo will attempt to write in
```

## The demo
The demo will demonstrate the following:
- That a container process is directly able to write into a host directory
- That the same write will fail when attempting as a non-root user and with capabilities dropped
- Therefore demonstrate least-privilege hardening and role of capabilities in controlling container access to host

Here is what each file in the demo does:

### Dockerfile
To build the docker container used in the demo. It will be configured with an extra non-root user 1001 to demonstrate point 2

### Demo-root.bash
The first part of the demo. It will:
- Build the image for use
- Create a container as root user
- Write a file, successfully into the bind-mounted host-data directory

### Demo-user.bash
The second aprt of the demo. It will:
- Create a container as user 1001 with all capabilities dropped
- Write a file unsuccessfully into the bind-mounted host-data directory