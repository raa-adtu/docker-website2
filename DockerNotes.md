# Docker — Complete Notes and Command Reference

These notes are structured for a **DevOps laboratory/class**, starting from Docker fundamentals and progressing to images, containers, Dockerfiles, networking, volumes, Compose, and practical exercises.

---

# 1. Introduction to Docker

## What is Docker?

**Docker** is an open-source platform used to **build, package, distribute, and run applications in containers**.

A container packages:

* Application code
* Libraries
* Dependencies
* Configuration
* Runtime environment

This allows an application to run consistently across different environments.

### Traditional deployment

```text
Application
     ↓
Operating System
     ↓
Libraries
     ↓
Dependencies
     ↓
Hardware
```

Problems:

* "Works on my machine" issues
* Dependency conflicts
* Difficult environment setup
* Different software versions

### Docker-based deployment

```text
Docker Host
    │
    ├── Container 1
    │    └── Application A
    │
    ├── Container 2
    │    └── Application B
    │
    └── Container 3
         └── Application C
```

Each container provides an isolated environment for its application.

---

# 2. Why Docker?

Docker provides:

### 1. Portability

The same container can run on:

```text
Developer Laptop
       ↓
Testing Server
       ↓
Production Server
       ↓
Cloud
```

### 2. Consistency

The development and production environments can use the same Docker image.

### 3. Isolation

Applications can run independently.

### 4. Lightweight deployment

Containers generally require fewer resources than traditional virtual machines.

### 5. Fast startup

Containers usually start much faster than complete virtual machines.

### 6. Scalability

Multiple containers can be started when application demand increases.

---

# 3. Docker vs Virtual Machine

![Image](https://images.openai.com/static-rsc-4/UGuqcqdx5MKiWkIfYJjRo1ZcEZ0KpMrO90rvKneX8uokd8uo90Rk91L7Ncmea3J-mG6S9AaV_JZ9v2JSoD9vpPche38B5rChBC0pyvo1rDKjIek62Eo8tucweWmtKsKzWNkGV824u4cz3pYo_ooT1EtZoozieGjldNvzpl521GizOsQp0ePrmtbgLjCVnaz1?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/MfvPrzsi0HnUELY8weoLTv1ke0wjn9QSIMMYI8QBk1mmOOCYcUzW_KoA9RIW1OmmbY6MbM3i7yJSQ68V4_SeJd2syUcklLhewJQAnlnN4t5ucO1hTkwN5OEP-Kweorl7m_WgLP-nspfnfltvCd4atde9ORxGo_nt9eKy67nITjkKP1ewcaeTPi8nevag92_H?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/InxQMc4aN8IMT12FOOUR7J0IGOwrHELh6xMtpcq_-KKZhs7YnH941tYSJbdyYDwY_1C2X9EvsUoQ3gaYe60gDpUBj2wWO6r-6Mx1lGYfmR974eNXSVsn9megBSfiZ-RGJrPkicv3KPNk-_WjLHW7AgWs5bz2AwB4uDN9E3w16NccEiGudZ7TdlLBUt_KBl57?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/B1z52lQhbIZJv7KhR68iYskh9YzVZPMXB8XB03taDXl0R5IMoXQtaA6hBwEB-KjINyDmZcNFkCKjPcf04nnqXUVgy_ai_9UXD_BbpZDYHBjyHkzrELfdU0QXNjD80DpgB3ljMIFmwB8dqPwHQ6Ah2IV_niDC6QgUiloXis3PzVOfZeEVXezGqAUbEgKczyd1?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ae2z8zQgytxRztr51EMd58XVAvBdmnTRW0z-mGG-Q1EedlsFgMpHh7X8_po537VVOgz0E2cH9iIUTIIVgRjhH8LYxg2yi2haalhYP6B_itB0PeB--ctu4eV4bpvRzJz2uFuXBjM3imUiPg2zIP5aQQKd8QyN96xyhYbcA6S_8McD4WCNC0FGaH5ElQWLdMWG?purpose=fullsize)

### Virtual Machine

```text
Hardware
   │
Host OS
   │
Hypervisor
   │
├── VM 1
│    ├── Guest OS
│    └── Application
│
└── VM 2
     ├── Guest OS
     └── Application
```

### Docker

```text
Hardware
   │
Host OS
   │
Docker Engine
   │
├── Container 1
│    └── Application
│
├── Container 2
│    └── Application
│
└── Container 3
     └── Application
```

### Comparison

| Feature        | VM                | Docker Container        |
| -------------- | ----------------- | ----------------------- |
| Virtualization | Hardware/OS level | OS-level                |
| Guest OS       | Required          | Usually not             |
| Size           | Larger            | Smaller                 |
| Startup        | Slower            | Faster                  |
| Resource usage | Higher            | Lower                   |
| Isolation      | Strong            | Process-level isolation |
| Portability    | Good              | Excellent               |

---

# 4. Docker Architecture

Docker uses a client-server architecture.

```text
             Docker Client
                  │
                  │ Docker API
                  ▼
             Docker Daemon
              (dockerd)
                  │
        ┌─────────┼─────────┐
        ▼         ▼         ▼
      Images   Containers  Networks
                  │
                  ▼
               Volumes
```

## Main components

### Docker Client

The command-line interface:

```bash
docker
```

Examples:

```bash
docker run
docker build
docker ps
docker images
```

### Docker Daemon

The Docker daemon:

```text
dockerd
```

manages:

* Images
* Containers
* Networks
* Volumes

### Docker Registry

A registry stores Docker images.

The most commonly used public registry is:

Docker Hub.

Images can be downloaded using:

```bash
docker pull nginx
```

### Docker Image

A read-only template used to create containers.

Examples:

```text
nginx
ubuntu
mysql
redis
node
python
```

### Docker Container

A running instance of an image.

```text
Image
  ↓
Container
```

---

# 5. Docker Image vs Container

This is one of the most important concepts.

### Image

An image is like a **blueprint/template**.

```text
nginx image
      │
      ├── Files
      ├── Libraries
      ├── Nginx
      └── Configuration
```

### Container

A container is a **running instance of an image**.

```text
nginx image
     │
     ├──────────→ Container 1
     │
     ├──────────→ Container 2
     │
     └──────────→ Container 3
```

One image can create multiple containers.

---

# 6. Check Docker Installation

```bash
docker --version
```

Example:

```text
Docker version 29.7.2
```

Detailed information:

```bash
docker info
```

Check Docker system:

```bash
docker system df
```

---

# 7. Docker Help

General help:

```bash
docker --help
```

Help for a particular command:

```bash
docker run --help
```

```bash
docker build --help
```

---

# 8. Docker Images

## List images

```bash
docker images
```

Modern equivalent:

```bash
docker image ls
```

## Pull an image

```bash
docker pull nginx
```

Specific version:

```bash
docker pull nginx:1.29
```

General format:

```text
image:tag
```

Example:

```text
nginx:latest
nginx:1.29
```

---

## Remove an image

```bash
docker rmi nginx
```

or:

```bash
docker image rm nginx
```

If a container is using the image, Docker may prevent removal.

---

## Inspect an image

```bash
docker image inspect nginx
```

---

## Image history

```bash
docker history nginx
```

This shows the layers used to build the image.

---

# 9. Docker Containers

## Create and run a container

```bash
docker run nginx
```

This creates and starts a container.

However, the terminal remains attached to the container.

---

## Run in background

```bash
docker run -d nginx
```

`-d` means:

**detached mode**

---

## Give a container a name

```bash
docker run -d --name mynginx nginx
```

---

# 10. Docker Port Mapping

Suppose Nginx listens on port 80 inside the container.

Run:

```bash
docker run -d --name mynginx -p 8080:80 nginx
```

Meaning:

```text
-p HOST_PORT:CONTAINER_PORT
```

Therefore:

```text
Windows/WSL
localhost:8080
       │
       ▼
Docker
       │
       ▼
Container port 80
       │
       ▼
Nginx
```

Open:

```text
http://localhost:8080
```

---

# 11. List Containers

Running containers:

```bash
docker ps
```

All containers:

```bash
docker ps -a
```

Example:

```text
CONTAINER ID   IMAGE   STATUS       PORTS       NAMES
91f7522cdc3d   nginx   Up 10 min    8080->80    mynginx
```

---

# 12. Container Lifecycle

The basic lifecycle is:

```text
             docker create
                   ↓
                Created
                   ↓
              docker start
                   ↓
                Running
                ↙     ↘
        docker stop   docker restart
             ↓
           Stopped
             ↓
         docker rm
             ↓
           Deleted
```

---

# 13. Start a Container

For an existing stopped container:

```bash
docker start mynginx
```

---

# 14. Stop a Container

```bash
docker stop mynginx
```

---

# 15. Restart a Container

```bash
docker restart mynginx
```

---

# 16. Remove a Container

First stop:

```bash
docker stop mynginx
```

Then:

```bash
docker rm mynginx
```

Force removal:

```bash
docker rm -f mynginx
```

---

# 17. Important Difference: `run` vs `start`

### `docker run`

Creates a **new container**.

```bash
docker run -d --name mynginx nginx
```

### `docker start`

Starts an **existing container**.

```bash
docker start mynginx
```

Remember:

```text
docker run   → CREATE + START
docker start → START existing
```

---

# 18. Execute Commands Inside a Container

Run a shell:

```bash
docker exec -it mynginx bash
```

If Bash isn't available:

```bash
docker exec -it mynginx sh
```

Example:

```bash
docker exec -it mynginx bash
```

Then:

```bash
pwd
ls
cd /usr/share/nginx/html
ls
```

Exit:

```bash
exit
```

---

# 19. View Container Logs

```bash
docker logs mynginx
```

Follow logs continuously:

```bash
docker logs -f mynginx
```

---

# 20. Inspect a Container

```bash
docker inspect mynginx
```

This provides information about:

* IP address
* Ports
* Networks
* Mounts
* Configuration
* Environment

---

# 21. Container Resource Usage

```bash
docker stats
```

This displays:

* CPU usage
* Memory usage
* Network
* Disk I/O

For one container:

```bash
docker stats mynginx
```

---

# 22. Dockerfile

A **Dockerfile** contains instructions for building a Docker image.

Example:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

---

# 23. Important Dockerfile Instructions

## FROM

Defines the base image.

```dockerfile
FROM nginx:latest
```

Other examples:

```dockerfile
FROM ubuntu:latest
```

```dockerfile
FROM python:3.13
```

```dockerfile
FROM node:24
```

---

## COPY

Copies files from the build context into the image.

```dockerfile
COPY index.html /usr/share/nginx/html/index.html
```

For multiple files:

```dockerfile
COPY *.html /usr/share/nginx/html/
```

---

## WORKDIR

Sets the working directory.

```dockerfile
WORKDIR /app
```

---

## RUN

Executes a command **while building the image**.

Example:

```dockerfile
RUN apt update
```

Another:

```dockerfile
RUN apt install -y curl
```

---

## CMD

Specifies the default command when a container starts.

Example:

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

---

## ENTRYPOINT

Defines the main executable of a container.

Example:

```dockerfile
ENTRYPOINT ["python"]
```

---

## EXPOSE

Documents the port used by the application.

```dockerfile
EXPOSE 80
```

**Important:** `EXPOSE` does not itself publish the port.

The port is published with:

```bash
docker run -p 8080:80 ...
```

---

## ENV

Defines environment variables.

```dockerfile
ENV APP_NAME="MyWebsite"
```

---

## ADD

Copies files and can also support some additional functionality such as extracting local archives.

```dockerfile
ADD file.tar.gz /app/
```

For ordinary copying, prefer:

```dockerfile
COPY
```

---

# 24. Build a Docker Image

Suppose you have:

```text
docker-website2/
├── Dockerfile
└── index.html
```

Build:

```bash
docker build -t my-website2 .
```

Explanation:

```text
docker build
     │
     ├── -t my-website2
     │       │
     │       └── Image name
     │
     └── .
         │
         └── Current directory
```

---

# 25. Complete HTML Docker Example

### Dockerfile

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

Build:

```bash
docker build -t my-website2 .
```

Run:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

Open:

```text
http://localhost:8082
```

---

# 26. Multi-Page Website

Project:

```text
docker-website2/
│
├── Dockerfile
├── index.html
├── about.html
├── courses.html
└── contact.html
```

Dockerfile:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY about.html /usr/share/nginx/html/about.html
COPY courses.html /usr/share/nginx/html/courses.html
COPY contact.html /usr/share/nginx/html/contact.html

EXPOSE 80
```

Build:

```bash
docker build -t my-website2 .
```

Run:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

Pages:

```text
http://localhost:8082
http://localhost:8082/about.html
http://localhost:8082/courses.html
http://localhost:8082/contact.html
```

---

# 27. Modify → Rebuild → Recreate

Suppose you modify:

```text
index.html
```

Your existing container doesn't automatically contain the modified file if you used `COPY` during image creation.

Build again:

```bash
docker build -t my-website2 .
```

Then:

```bash
docker stop my-website2-container
docker rm my-website2-container
```

Create a new container:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

This is the normal workflow for this simple Dockerfile:

```text
Modify Code
     ↓
Build Image
     ↓
Stop Old Container
     ↓
Remove Old Container
     ↓
Run New Container
     ↓
Test
```

---

# 28. Docker Volumes

Containers are designed to be replaceable. If you need data to survive container deletion, use **volumes**.

Create a volume:

```bash
docker volume create mydata
```

List volumes:

```bash
docker volume ls
```

Inspect:

```bash
docker volume inspect mydata
```

Use a volume:

```bash
docker run -d \
  --name mycontainer \
  -v mydata:/data \
  ubuntu
```

Here:

```text
-v volume_name:container_path
```

---

# 29. Bind Mounts

A bind mount connects a host directory to a container directory.

Example:

```bash
docker run -d \
  --name mynginx \
  -p 8080:80 \
  -v ~/website:/usr/share/nginx/html \
  nginx
```

Now:

```text
WSL:
~/website
    │
    │ bind mount
    ▼
Container:
/usr/share/nginx/html
```

This is especially useful during **development**, because modifying the files on the host can immediately affect what the container serves.

---

# 30. Docker Networks

List networks:

```bash
docker network ls
```

Inspect a network:

```bash
docker network inspect bridge
```

Create a network:

```bash
docker network create mynetwork
```

Run a container on it:

```bash
docker run -d \
  --name web \
  --network mynetwork \
  nginx
```

Run another:

```bash
docker run -d \
  --name app \
  --network mynetwork \
  ubuntu
```

Containers on the same user-defined network can communicate using container names.

For example:

```text
app → web
```

can use:

```text
http://web
```

---

# 31. Docker Container Networking

Common Docker networks include:

```text
bridge
host
none
```

### Bridge

Default network for most containers.

```bash
docker run nginx
```

### Host

Container shares the host's network namespace.

```bash
docker run --network host nginx
```

### None

Disables normal network connectivity:

```bash
docker run --network none nginx
```

---

# 32. Docker Compose

Docker Compose is used to define and manage **multi-container applications**.

Instead of many commands:

```bash
docker run ...
docker run ...
docker network ...
docker volume ...
```

you can define everything in:

```text
compose.yaml
```

Example:

```yaml
services:

  web:
    image: nginx
    ports:
      - "8080:80"

  redis:
    image: redis
```

Start:

```bash
docker compose up -d
```

Check:

```bash
docker compose ps
```

Stop:

```bash
docker compose down
```

View logs:

```bash
docker compose logs
```

---

# 33. Docker Compose Build Example

Project:

```text
myproject/
├── compose.yaml
├── Dockerfile
└── index.html
```

`compose.yaml`:

```yaml
services:

  website:
    build: .
    ports:
      - "8082:80"
```

Build and run:

```bash
docker compose up -d --build
```

Open:

```text
http://localhost:8082
```

This is particularly useful when moving from a single-container exercise to applications containing multiple services.

---

# 34. Docker Registry

A Docker registry stores images.

Typical workflow:

```text
Build Image
     ↓
Tag Image
     ↓
Push Image
     ↓
Docker Registry
     ↓
Pull Image
     ↓
Another Computer
```

For Docker Hub, authenticate with:

```bash
docker login
```

Tag:

```bash
docker tag my-website2 username/my-website2:latest
```

Push:

```bash
docker push username/my-website2:latest
```

Another computer can pull:

```bash
docker pull username/my-website2:latest
```

---

# 35. Docker Tags

An image can have multiple tags.

Example:

```bash
docker tag my-website2 my-website2:v1
```

Then:

```bash
docker images
```

You might see:

```text
my-website2   latest
my-website2   v1
```

A useful versioning approach is:

```text
my-website2:v1
my-website2:v2
my-website2:v3
```

---

# 36. Useful Cleanup Commands

Remove stopped containers:

```bash
docker container prune
```

Remove unused images:

```bash
docker image prune
```

Remove unused volumes:

```bash
docker volume prune
```

Remove unused networks:

```bash
docker network prune
```

Remove unused Docker objects:

```bash
docker system prune
```

Be careful with cleanup commands because they permanently delete resources that are no longer being used.

---

# 37. Docker System Information

Disk usage:

```bash
docker system df
```

Detailed:

```bash
docker system df -v
```

Docker information:

```bash
docker info
```

---

# 38. Frequently Used Docker Commands

### Images

```bash
docker images
docker pull nginx
docker build -t myimage .
docker rmi myimage
docker image inspect myimage
docker history myimage
```

### Containers

```bash
docker ps
docker ps -a
docker run nginx
docker run -d nginx
docker run -d --name mynginx nginx
docker start mynginx
docker stop mynginx
docker restart mynginx
docker rm mynginx
docker rm -f mynginx
```

### Container interaction

```bash
docker exec -it mynginx bash
docker logs mynginx
docker logs -f mynginx
docker inspect mynginx
docker stats
```

### Networking

```bash
docker network ls
docker network create mynetwork
docker network inspect mynetwork
docker network rm mynetwork
```

### Volumes

```bash
docker volume ls
docker volume create mydata
docker volume inspect mydata
docker volume rm mydata
```

### Compose

```bash
docker compose up
docker compose up -d
docker compose up -d --build
docker compose ps
docker compose logs
docker compose down
```

---

# 39. Important Docker Command Patterns

### Run a container

```bash
docker run [OPTIONS] IMAGE
```

Example:

```bash
docker run -d --name web -p 8080:80 nginx
```

### Build an image

```bash
docker build -t IMAGE_NAME .
```

Example:

```bash
docker build -t my-website2 .
```

### Execute inside a container

```bash
docker exec -it CONTAINER bash
```

Example:

```bash
docker exec -it my-website2-container bash
```

---

# 40. Common Docker Errors

## Error 1: Container name already exists

```text
Conflict. The container name "/mynginx" is already in use
```

Solution:

Check:

```bash
docker ps -a
```

If you want to use the existing container:

```bash
docker start mynginx
```

Or remove it:

```bash
docker rm mynginx
```

---

## Error 2: Port already allocated

```text
Bind for 0.0.0.0:8080 failed:
port is already allocated
```

Find which container uses the port:

```bash
docker ps
```

If:

```text
mynginx → 8080
```

use another port:

```bash
docker run -d --name website2 -p 8081:80 nginx
```

---

## Error 3: Container is not running

```text
container ... is not running
```

Check:

```bash
docker ps -a
```

Start it:

```bash
docker start container_name
```

---

## Error 4: Image not found

```text
Unable to find image
```

Pull it:

```bash
docker pull nginx
```

---

# 41. Docker in Your WSL Environment

Your current environment is essentially:

```text
Windows
   │
   ▼
WSL 2
   │
   ▼
Ubuntu 26.04
   │
   ▼
Docker Engine 29.7.2
   │
   ├── nginx
   ├── my-website1
   ├── my-website2
   └── hello-world
```

Your current websites can coexist:

```text
mynginx
   ↓
localhost:8080

my-website1-container
   ↓
localhost:8081

my-website2-container
   ↓
localhost:8082
```

This is a good demonstration of **container isolation and port mapping**.

---

# 42. Recommended Docker Lab Sequence

For your DevOps course, I recommend teaching Docker in this order.

### Lab 1 — Docker Basics

```bash
docker --version
docker info
docker run hello-world
docker images
docker ps
docker ps -a
```

### Lab 2 — Nginx

```bash
docker pull nginx
docker run -d --name mynginx -p 8080:80 nginx
docker ps
```

Browser:

```text
http://localhost:8080
```

### Lab 3 — Custom HTML Website

```text
index.html
Dockerfile
```

Build:

```bash
docker build -t my-website1 .
```

Run:

```bash
docker run -d --name my-website1-container -p 8081:80 my-website1
```

### Lab 4 — Multi-page Website

```text
index.html
about.html
courses.html
contact.html
Dockerfile
```

Build:

```bash
docker build -t my-website2 .
```

Run:

```bash
docker run -d --name my-website2-container -p 8082:80 my-website2
```

### Lab 5 — Modify and Rebuild

```text
Modify
  ↓
Build
  ↓
Stop
  ↓
Remove
  ↓
Run
  ↓
Test
```

### Lab 6 — Volumes

Learn:

```bash
docker volume
```

and:

```bash
-v
```

### Lab 7 — Docker Networking

Learn:

```bash
docker network
```

### Lab 8 — Docker Compose

Create:

```text
compose.yaml
```

and run:

```bash
docker compose up -d
```

### Lab 9 — Docker Hub

Learn:

```bash
docker login
docker tag
docker push
docker pull
```

### Lab 10 — CI/CD + Docker

Finally connect:

```text
Git
 ↓
GitHub
 ↓
Docker Build
 ↓
Docker Image
 ↓
Docker Registry
 ↓
Deployment
```

This progression takes students from **basic container commands → Dockerfile → custom website → persistent data → networking → multi-container applications → image publishing → CI/CD**, which fits very well into a DevOps course.
