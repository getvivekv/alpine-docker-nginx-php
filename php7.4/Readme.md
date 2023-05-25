## A minimal production ready Docker image for PHP 7.4 + Nginx + PHP-FPM + Alpine (about ~70MB)

![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## Features
- Alpine 3.14
- PHP 7.4
- Nginx + PHP FPM optimized
- Custom nginx configuration
    - Able to run php files without .php extension
- Runit (instead of Supervisord)    
- Composer latest
- Common PHP extensions
 
  
## Usage

```dockerfile
FROM getvivekv/alpine-docker-nginx-php7
# Copy your project content
COPY html /var/www/html
RUN composer install --optimize-autoloader --no-interaction --no-progress
```

### Adding custom PHP settings

An optimized php.ini for production is loaded by default. You can add additional parameters to this php.ini. Example

```Dockerfile
FROM getvivekv/alpine-docker-nginx-php7
# Copy your project content
COPY html /var/www/html/
RUN composer install --optimize-autoloader --no-interaction --no-progress
RUN echo "session.save_handler = redis" >> /etc/php7/conf.d/custom.ini && \
    echo 'session.save_path = "tcp://redis:6379"' >> /etc/php7/conf.d/custom.ini
```

### Adding custom shell scripts to execute before nginx starts

If you have any shell script that you would want to execute before nginx starts, put those in a folder and add those to `/startup.d`

```Dockerfile
FROM getvivekv/alpine-docker-nginx-php7
# Copy your project content
COPY html /var/www/html
RUN composer install --optimize-autoloader --no-interaction --no-progress
RUN echo "session.save_handler = redis" >> /etc/php7/conf.d/custom.ini && \
    echo 'session.save_path = "tcp://redis:6379"' >> /etc/php7/conf.d/custom.ini
ADD startup /startup.d/
```
