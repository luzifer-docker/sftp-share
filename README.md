# luzifer/sftp-share Dockerfile

This repository contains **Dockerfile** of sftp-share for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/luzifer/sftp-share/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image

- [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

## Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/luzifer/sftp-share/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull luzifer/sftp-share`

## Usage

To launch it and have your share listen on port 2022, just type:

```
docker run -d -p 2022:22 -e USER=myuser -e PASS=myverysecretpassword luzifer/sftp-share
```
