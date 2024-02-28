# Dockerfile

# Use the official PHP image with Nginx and PHP-FPM
FROM webdevops/php-nginx:8.3

# Set working directory
WORKDIR /var/www/html

# Copy the application code to the container
COPY . /var/www/html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"


# Configure Nginx for Symfony
COPY ./nginx/symfony.conf /opt/docker/etc/nginx/vhost.common.d/10-location-root.conf

# Expose port 80
EXPOSE 80
