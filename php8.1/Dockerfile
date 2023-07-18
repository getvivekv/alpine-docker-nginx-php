FROM alpine:3.18
RUN apk --no-cache add nano php81 php81-fpm php81-opcache php81-mysqli php81-json php81-openssl php81-curl php81-iconv \
    php81-zlib php81-xml php81-phar php81-intl php81-dom php81-xmlreader php81-ctype php81-session php81-zip php81-tokenizer \
    php81-mbstring php81-gd nginx curl php81-redis php81-simplexml php81-pdo_mysql runit && \
    rm -f /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY config/php.ini /etc/php81/conf.d/custom.ini
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