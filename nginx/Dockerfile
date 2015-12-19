FROM symfony-base

MAINTAINER Iulian Popa <iulyanpopa@gmail.com>

RUN apk --update add nginx

RUN mkdir -p /etc/nginx/sites-available/
RUN mkdir -p /etc/nginx/sites-enabled/
RUN mkdir -p /var/log/nginx
RUN chown -R symfony /var/log/nginx
RUN chgrp -R symfony /var/log/nginx
#RUN chmod -R 0777 /var/log/nginx
#RUN umask 0000

COPY nginx.conf /etc/nginx/

COPY vhost.conf /etc/nginx/sites-available/symfony.conf
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

CMD ["nginx"]