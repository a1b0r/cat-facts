# Rails task
Get cat fact from https://catfact.ninja/fact, save to DB and display

## Features

* Your user and group are forwarded into this container, so you're the same user inside and outside the container.

## Usage

### First time usage

Before the first start, you have to create all Docker-related files. Do this be executing

```
$ docker_development/setup_development
```

Afterwards you have to install some packages and create a database, do this by executing this:

```
$ ./dc up
[Open a new tab in your terminal]
$ ./dc exec app bash
$ yarn
$ rails db:create
```

### Starting, stopping, executing, ...

This project comes with a bash script named `dc`. Use it like you would use `docker-compose`. So `./dc up` executes something like `docker-compose up`. `./dc exec -u root app bash` opens a root bash in the app container, like `docker-compose exec -u root app bash` would.

## Starting

Start this project by executing `./dc up`. This starts the rails and mariadb containers.

### Start the rails application

Open a new tab in your terminal and execute

```
$ ./dc exec app bash
$ rails s -b 0.0.0.0 -e development
[If you need the webpack-dev-server]
[Then open another terminal tab and execute]
$ bin/webpack-dev-server
```

### Access the application

No matter if you started the webpack-dev-server or not, you can access your application at [localhost:3000](http://localhost:3000).

## Idea behind this and why do I need this dc script?

`docker-compose` expects the compose file to be named `docker-compose.yml` and `docker-compose.override.yml`. In order to use this docker setup for local development and production purposes without having to copy&paste the compose file, we need a module based approach. So `docker-compose.base.yml` creates all services your application requires and `docker-compose.development.yml` adds development stuff like volumes and so on.
