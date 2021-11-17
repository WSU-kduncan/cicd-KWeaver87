# CEG3120 Project 6

This is a class project for CEG3120. The goal is to create a Dockerfile that hosts a static HTML file.

## Part 1

### Run Project Locally

- Install Docker (rootless) on home computer (running Manjaro): `pamac install docker-rootless-extras-bin` and reference [Docker-ArchWiki](https://wiki.archlinux.org/title/Docker#Docker_rootless) to get working.
- Build container: `docker build --pull -f "Dockerfile" -t cicdkweaver87:latest "."`
- Run container (locally): `docker run --rm -d -p 8080:80 cicdkweaver87:latest`
- View project locally: http://localhost:8080

## Part 2

TODO:

## Part 3

TODO: [Reference for ACME](https://wiki.alpinelinux.org/wiki/Nginx_as_reverse_proxy_with_acme_(letsencrypt))