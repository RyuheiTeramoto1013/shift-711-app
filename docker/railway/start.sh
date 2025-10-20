#!/bin/bash

# Laravel requires the storage and bootstrap/cache directories to be writable.
chown -R application:application /var/www/html/storage /var/www/html/bootstrap/cache

# Clear any previously cached configuration, routes, or views.
# This forces Laravel to read fresh environment variables on boot.
php artisan optimize:clear

# Run database migrations.
# Without a config cache, this command will read variables directly from the environment.
php artisan migrate --force

# Start PHP-FPM in the background.
/usr/local/bin/php-fpm &

# Start Nginx in the foreground. This keeps the container running.
nginx -g "daemon off;"