FROM iulyanpopa/alpine-node

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add python \
        python-dev \
        make \
        g++ \
    && npm install -g gulp \
    && rm -rf /tmp/*

VOLUME /var/www
WORKDIR /var/www

CMD ["gulp"]
