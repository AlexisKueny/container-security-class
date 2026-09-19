# How to understand this repository
This repository contains my research and a script containing the bash and docker commands I will be using during the demo.

## The demo
The demo will demonstrate the following:
- That a container process is directly able to write into a host directory
- That the same write will fail when attempting as a non-root user and with capabilities dropped
- Therefore demonstrate least-privilege hardening and role of capabilities in controlling container access to host
