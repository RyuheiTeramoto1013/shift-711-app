#!/bin/bash

# Wait for services to be ready
sleep 5

# Clear all caches safely
php artisan optimize:clear

# Run database migrations
php artisan migrate --force

# Start PHP-FPM in the background
/usr/local/bin/php-fpm &

# Start Nginx in the foreground
nginx -g "daemon off;"