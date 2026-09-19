## Linux container anatomy

All 3 below are set by the host on the container

### Namespaces: What can this process see?
- A namespace wraps a global system resource so that processes inside it see their own isolated instance of that resource, not the host's.

### Cgroups: How much can I use?
- A cgroup groups processes together and applies resource limits, accounting, and control to that group.
- Namespaces isolate visibility. cgroups isolate consumption. They let the kernel say: "This group of processes may use at most 512 MB of RAM, 50% of one CPU core, and 10 MB/s of disk write."

__What cgroups control__
Resource	What you can limit
CPU	Shares, quota, period (e.g., 0.5 cores)
Memory	Hard limit, soft limit, swap usage
Block I/O	Read/write bytes per second, IOPS
PIDs	Max number of processes (fork bomb protection)
Devices	Which device nodes can be accessed
Hugepages, RDMA, etc.	Specialized resources

### Capabilites
Capabilities split the all-powerful root privilege into ~40 distinct, granular permissions.

The important capabilities
Capability	What it allows
CAP_CHOWN	Change file ownership
CAP_NET_BIND_SERVICE	Bind to ports < 1024
CAP_NET_ADMIN	Configure network interfaces, routing, firewall
CAP_SYS_ADMIN	Mount filesystems, many admin ops (very powerful)
CAP_SYS_PTRACE	Trace/debug other processes
CAP_SYS_MODULE	Load/unload kernel modules (dangerous)
CAP_DAC_OVERRIDE	Bypass file read/write/execute permission checks
CAP_SETUID / CAP_SETGID	Change process UIDs/GIDs