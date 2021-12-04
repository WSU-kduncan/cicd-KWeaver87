# CEG3120 Project 6

This is a class project for CEG3120. The goal is to create a Dockerfile that hosts a static HTML file.

## Part 1 - Dockerize it

### Run Project Locally

- Install Docker (rootless) on home computer (running Manjaro): `pamac install docker-rootless-extras-bin` and reference [Docker-ArchWiki](https://wiki.archlinux.org/title/Docker#Docker_rootless) to get working.
- Build container: `docker build --pull -f "Dockerfile" -t weaver254wright/cicdweaver254:latest "."`
- Run container (locally): `docker run --rm -d -p 8080:80 weaver254wright/cicdweaver254:latest`
- View project locally: http://localhost:8080

## Part 2 - GitHub Actions and DockerHub

### Create DockerHub public repo

- On [Docker Hub](https://hub.docker.com/), select "Create a Repository"
- Enter repository name and ensure Visibility is set to Public
- Click Create

### Allow DockerHub authentication via CLI using DockerHub credentials

- On Docker Hub, enter [Account Settings](https://hub.docker.com/settings/general) and select [Security](https://hub.docker.com/settings/security) from Menu
- Create new Read, Write, Delete token named "CLI & GitHub"
  - (Preferably would create separate tokens for each, but a free DockerHub account is limited to a single token. ☹)
- Run `docker login -u weaver254wright` and enter access token

### Configure GitHub Secrets

- Enter repository's [Settings](https://github.com/WSU-kduncan/cicd-KWeaver87/settings) page and select [Secrets](https://github.com/WSU-kduncan/cicd-KWeaver87/settings/secrets/actions)
- Use "New repository secret" to create DOCKER_HUB_USERNAME and DOCKER_HUB_ACCESS_TOKEN, entering your username and token created above

### Configure GitHub Workflow

- Enter repository's new [Actions](https://github.com/WSU-kduncan/cicd-KWeaver87/actions/new) page (Actions button links here if the repo does not already have an Action)
- Find "Docker image" and click its "Set up this workflow" button
- Follow [DockerHub's instructions on Configure GitHub Actions](https://docs.docker.com/ci-cd/github-actions/) to configure the YAML file to fit your repo
- Create commit using the strategy of your choice

## Part 3 - Deployment

### Pulling the image & Running the container

A CloudFormation template's [install script](./Project6-cf.yml#L141) handles these steps.

### Post-install ACME commands

The server won't work properly until SSL is fully configured, as it is set to forward connections to HTTPS. Best not to automate these commands, as they depend upon the domain name being resolvable.

SSH into host, then and run acme.sh commands as root (`sudo -i`).

Register and issue cert:

```sh
acme.sh --register-account -m email@address.com
acme.sh --issue -d your.domain.here --standalone
```

Install cert:

```sh
acme.sh --install-cert -d your.domain.here \
  --cert-file /etc/nginx/ssl/cert \
  --key-file /etc/nginx/ssl/key \
  --fullchain-file /etc/nginx/ssl/fullchain
```

### SSL info

The container will store the SSL certs persistently in `/etc/nginx/ssl` on the EC2 instance. It's best to not lose these, otherwise you'll have to get a new cert issued.
