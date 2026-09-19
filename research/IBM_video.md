## Pros and cons of containers over VMs

__Pros__
- Smoothen developement
- Deploy anywhere

__Cons__
- Exposed to exterior attacks

## Vulnerabilities and how to adress them
- Images to build containers:
    - Keep image up to date, have security patches
    - Scanning images, track uncaught vulnerabilities
    - Signing images, verify who tries to manipulate the image
- Image registries to store images:
    - Vulnerability: contains all images which contains app code
    - Keep your registries private
    - Monitor your registries
    - Host server secured, protect from unwanted access
- Container runtimes to execute containers:
    - App security up to par
    - Monitor network
- Orchestration platforms (k8s) to manage container lifecycles:
    - Set access controls, regulate users and priveleges (least privilege protocol)
    - Monitor the platform, pod communication
- Host OS, which manages docker client and kernel shared with running containers:
    - Greatest vulnerability!
    - Use a light OS (certain linux distros)
    - Access control in your OS
    - Monitor your OS

## Open source tools to use
- Scanning tools
    - DockerBench: run and test your container against best practices and evaluate
    -  OpenSCAP: create schedules for continuous scanning
- Monitoring
    - Prometheus: collect and analyze metrics in communication
- Firewall:
    - Cilium: monitor network

