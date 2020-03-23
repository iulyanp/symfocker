symfocker
==============

A Docker setup environment for web development in Symfony3 Framework based on 
[Alpine Linux](https://github.com/gliderlabs/docker-alpine), 
[Docker](https://docs.docker.com/) and [docker-compose2](https://docs.docker.com/compose/install/).

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


#### Step 1 - Clone this repository:

```bash
$ git clone git@github.com:iulyanpopa/symfocker.git
```

#### Step 2 - Place your Symfony 3 application into `www`

Next, install your Symfony application into `www` folder and don't forget to add `127.0.0.1 app.dev` 
in your `/etc/hosts` file if you want to be able to visit `http://app.dev`.

#### Step 3 - Export your user user id and group id

One of the bigger problems with docker in development is that, in docker, by default you have `root` permissions and 
locally you change the code with your own user. This leads to a lot of problems.
I fixed this issue very simple by mapping the local user id and group id into docker.
All you have to do is to export the `MY_UID` and `MY_GID` with your user id and group id.
You can check to see your specific user and group id on linux with `id`.

```sh
$ uid=1000(iulyanp) gid=1000(iulyanp) ...
```

You can set default values for environment variables using a .env file, which Compose will automatically look for. 
Values set in the shell environment will override those set in the .env file.

```sh
$ echo "MY_UID=1000" >> .env
$ echo "MY_GID=1000" >> .env
```
#### Step 4 - Start the containers

```sh
$ docker-compose up -d
```

That's it, you are done. You can visit your Symfony 3 application on the following URL: [symfony.dev](http://symfony.dev)

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

The built images:

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

   Name                  Command               State                                                     Ports
---------------------------------------------------------------------------------------------------------------------------------------------------------------
data          true                             Exit 0
sf-elk        /usr/bin/supervisord -n -c ...   Up       0.0.0.0:81->80/tcp
sf-mysql      /entrypoint.sh mysqld            Up       0.0.0.0:3306->3306/tcp, 33060/tcp
sf-nginx      nginx                            Up       0.0.0.0:80->80/tcp
sf-php-fpm    /bin/sh -c entrypoint.sh         Up
sf-rabbitmq   docker-entrypoint.sh rabbi ...   Up       15671/tcp, 0.0.0.0:8081->15672/tcp, 25672/tcp, 4369/tcp, 0.0.0.0:5671->5671/tcp, 0.0.0.0:5672->5672/tcp
sf-redis      docker-entrypoint.sh redis ...   Up       0.0.0.0:6379->6379/tcp      
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


