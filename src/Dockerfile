FROM antonienko/phalcon-php7

RUN apt-get -y install php-redis
COPY php.ini /etc/php/7.0/fpm/php.ini
COPY nginx-default.conf /etc/nginx/sites-available/default
RUN /etc/init.d/nginx reload

WORKDIR /var/www/
