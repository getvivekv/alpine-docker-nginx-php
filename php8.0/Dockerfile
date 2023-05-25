FROM alpine:3.16
RUN apk --no-cache add nano php8 php8-fpm php8-opcache php8-mysqli php8-json php8-openssl php8-curl php8-iconv \
    php8-zlib php8-xml php8-phar php8-intl php8-dom php8-xmlreader php8-ctype php8-session php8-zip \
    php8-mbstring php8-gd nginx curl php8-redis php8-simplexml php8-pdo_mysql runit && \
    rm -f /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY config/php.ini /etc/php8/conf.d/custom.ini
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