symfocker
==============

A Docker setup environment for Symfony2 Framework with [Alpine Linux](https://github.com/gliderlabs/docker-alpine), 
[Docker](https://docs.docker.com/) and [docker-compose](https://docs.docker.com/compose/install/).

### Why Alpine?

Docker images are usually much larger than they need to be. Alpine has only 5MB:

```bash
REPOSITORY           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
alpine               latest              32653661039d        10 days ago         5.253 MB
```

### Installation

Clone this repository:

```bash
$ git clone git@github.com:iulyanp/symfocker.git
```

Next, install your Symfony application into `symfony` folder and don't forget to add `127.0.0.1 symfony.dev` 
in your `/etc/hosts` file.

Quick run:

```sh
$ ./build.sh
```
or you can build them yourself one by one

```sh
$ docker build -t symfony-base web-base
$ docker build -t symfony-php-fpm php-fpm
$ docker build -t symfony-nginx nginx
$ docker-compose up -d
```

And that's it, you are done, you can visite your Symfony application on the following URL: [symfony.dev](http://symfony.dev)

### How it works?

The builded images:

```sh
> $ docker images

REPOSITORY           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
symfony-nginx        latest              2fc6097d3e6f        3 minutes ago       7.43 MB
symfony-php-fpm      latest              a566ead21301        5 minutes ago       48.27 MB
symfony-base         latest              be0ed8829fc6        7 minutes ago       5.259 MB
alpine               latest              32653661039d        10 days ago         5.253 MB
mysql/mysql-server   latest              c312e735b441        11 days ago         294.6 MB
```

Running containers:

```sh
> $ docker-compose ps

     Name                 Command            State            Ports          
----------------------------------------------------------------------------
symfony           true                       Exit 0                          
symfony-mysql     /entrypoint.sh mysqld      Up       0.0.0.0:3306->3306/tcp
symfony-nginx     nginx                      Up       0.0.0.0:80->80/tcp
symfony-php-fpm   /bin/sh -c entrypoint.sh   Up  
```

* `symfony`: This is a data only container that contains the Symfony code,
* `symfony-mysql`: This is the MySQL database container
* `symfony-php-fpm`: This is the PHP-FPM container in which the application volume is mounted,
* `symfony-nginx`: This is the Nginx webserver container in which application volume is mounted too

### Logs

Nginx and Symfony application logs are mapped into your host machine in `logs/nginx` and `logs/symfony`

