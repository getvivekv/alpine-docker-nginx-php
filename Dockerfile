FROM alpine:3.12
RUN apk --no-cache add php7 php7-fpm php7-opcache php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd nginx curl php7-redis php7-simplexml php7-pdo_mysql php7-mcrypt runit && \
    rm -f /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/custom.ini
COPY config/boot.sh /sbin/boot.sh
COPY config/service /etc/service
RUN chmod +x /etc/service/*/run && \
    chmod +x /sbin/boot.sh
EXPOSE 80
COPY src/ /var/www/html
CMD [ "/sbin/boot.sh" ]
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html