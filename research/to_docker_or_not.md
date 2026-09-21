# Notes

## Security
Key takeaways for security measures described in the document

### Isolation
Docker containers rely exclusively on Linux kernel features, including namespaces, cgroups, hardening, and capabilities. Namespace isolation and capabilities drop are enabled by default, but cgroups limitations aren't; they must be enabled on a per-container basis through - a - c options on container launch. The default isolation configuration is relatively strict. The only flaw is that all containers share the same network bridge, enabling Address Resolution Protocol (ARP) poisoning attacks between containers on the same host.

### Network
To distribute images, Docker verifies images downloaded from a remote repository with a hash and the connection to the registry is made over TLS (unless explicitly specified otherwise). Moreover, the Docker Content Trust architecture now lets developers sign their images before pushing them to a repository.10 Content Trust relies on the update framework (TUF),11 which was specifically designed to address package manager flaws.12 TUF can recover from a key compromise, mitigate replay attacks by embedding expiration timestamps in signed images, and so on. The tradeoff is complex key management; TUF actually implements a public-key infrastructure in which each developer owns a root key (“offline key”) that is used to sign “signing keys” that are used to sign Docker images.

The Docker daemon is remote-controlled through a socket, making it possible to perform any Docker command from another host. By default, the socket used to control the daemon is a Unix socket, located at /var/run/docker.sock and owned by root:docker, but it can be changed to a TCP socket. Access to this socket lets attackers pull and run any container in privileged mode, thereby giving them root access to the host. In case of a Unix socket, a user member of the docker group can gain root privileges; when a TCP socket is used, any connection to this socket can give root privileges on the host. Therefore, the connection must be secured with TLS (-tlsverify), which enables both encryption and authentication of the two sides of the connection (and requires additional certificate management).

### Dangers

- In-production containers. With containers from an Internet-facing container service, for example, attackers can gain root privileges on a related container. Then, from the compromised container, they can make a denial-of-service (DoS) attack on containers located on the same host operating system.
- In-production host operating system. From a compromised container, for example, attackers can gain access to critical host operating system files—that is, launch a container escape attack.
- In-production Docker daemons. In this case, for example, attackers might lower the default security parameters to launch Docker containers from a compromised host operating system.
- The production network. From a compromised host operating system, attackers can redirect network traffic and so on.

