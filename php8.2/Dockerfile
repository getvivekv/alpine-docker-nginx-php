FROM alpine:3.18
RUN apk --no-cache add nano php82 php82-fpm php82-opcache php82-mysqli php82-json php82-openssl php82-curl php82-iconv \
    php82-zlib php82-xml php82-phar php82-intl php82-dom php82-xmlreader php82-ctype php82-session php82-zip \
    php82-mbstring php82-gd nginx curl php82-redis php82-simplexml php82-pdo_mysql runit && \
    rm -f /etc/nginx/conf.d/default.conf && ln -s /usr/bin/php82 /usr/bin/php
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php82/php-fpm.d/www.conf
COPY config/php.ini /etc/php82/conf.d/custom.ini
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