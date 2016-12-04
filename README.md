symfocker
==============

A Docker setup environment for Symfony3 Framework with [Alpine Linux](https://github.com/gliderlabs/docker-alpine), 
[Docker](https://docs.docker.com/) and [docker-compose](https://docs.docker.com/compose/install/).

### Why Alpine?

Docker images are usually much larger than they need to be. Alpine has only 5MB:

```bash
REPOSITORY           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
alpine               latest              32653661039d        10 days ago         5.253 MB
```
### Requirements

Before you try this project you have to install:
- docker engine
- docker-compose
- your project should be a >= Symfony 3.0

### Installation

Clone this repository:

```bash
$ git clone git@github.com:iulyanpopa/symfocker.git
```

Next, install your Symfony application into `www` folder and don't forget to add `127.0.0.1 app.dev` 
in your `/etc/hosts` file if you want to be able to visit `http://app.dev`.

Quick run:

```sh
$ docker-compose up -d
```
And that's it, you are done, you can visit your Symfony3 application on the following URL: [symfony.dev](http://symfony.dev)


You can also build these images yourself one by one with the `build` script

```sh
$ sh build 1
```

or like this

```sh
$ docker build -t iulyanpopa/alpine-web:latest .
$ docker build -t iulyanpopa/alpine-php-fpm:latest .
$ docker build -t iulyanpopa/alpine-nginx:latest .
$ docker-compose up -d
```

### How it works?

The builded images:

```sh
> $ docker images

REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
iulyanpopa/alpine-php-fpm     latest              63d85729482e        About an hour ago   99.79 MB
iulyanpopa/alpine-nginx       latest              4f647f5c8fd7        About an hour ago   6.889 MB
iulyanpopa/alpine-web         latest              4d44e9656125        About an hour ago   4.808 MB
mysql/mysql-server            latest              6272a6121ff6        About an hour ago   316.2 MB
alpine                        latest              baa5d63471ea        About an hour ago   4.803 MB
```

Running containers:

```sh
> $ docker-compose ps

 Name             Command            State                  Ports               
-------------------------------------------------------------------------------
data      true                       Exit 0                                     
mysql     /entrypoint.sh mysqld      Up       0.0.0.0:3306->3306/tcp, 33060/tcp 
nginx     nginx                      Up       0.0.0.0:80->80/tcp                
php-fpm   /bin/sh -c entrypoint.sh   Up               
```

* `data`: This is a data only container that contains the Symfony code,
* `mysql`: This is the MySQL database container
* `php-fpm`: This is the PHP-FPM container in which the application volume is mounted,
* `nginx`: This is the Nginx webserver container in which application volume is mounted too

### Logs

Nginx and Symfony application logs are mapped into your host machine in a named volume `symfocker_logs`
You can inspect the `symfocker_logs` volume.

```sh
$ docker volume inspect symfocker_logs
[
    {
        "Name": "symfocker_logs",
        "Driver": "local",
        "Mountpoint": "/var/lib/docker/volumes/symfocker_logs/_data",
        "Labels": null,
        "Scope": "local"
    }
]
```

You can check the logs like this:

```
$ sudo ls -la /var/lib/docker/volumes/symfocker_logs/_data
```

The database is mapped into a second named volume `symfocker_database`.

A third named volume is created for mapping the `php-fpm.socket` between the `php-fpm` and `nginx` containers.

Behind the scenes an `symfocker_symfony` network is created and all those containers are running in this network.


