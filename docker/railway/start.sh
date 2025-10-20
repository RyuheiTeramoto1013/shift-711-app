#!/bin/bash

# --- Robust Database Wait Script ---
echo "Waiting for database connection..."
ATTEMPTS=0
MAX_ATTEMPTS=30

# Loop until the database connection is successful or we run out of attempts.
until php -r "try { new PDO('mysql:host=${MYSQLHOST};port=${MYSQLPORT};dbname=${MYSQLDATABASE}', '${MYSQLUSER}', '${MYSQLPASSWORD}'); } catch (PDOException \$e) { exit(1); }"; do
    ATTEMPTS=$((ATTEMPTS+1))
    if [ ${ATTEMPTS} -gt ${MAX_ATTEMPTS} ]; then
        echo "Database connection failed after ${MAX_ATTEMPTS} attempts."
        exit 1
    fi
    echo "  ...attempt ${ATTEMPTS} of ${MAX_ATTEMPTS}, waiting 2 seconds..."
    sleep 2
done
echo "Database connection successful!"
# --- End of Wait Script ---

# Laravel requires the storage and bootstrap/cache directories to be writable.
chown -R application:application /var/www/html/storage /var/www/html/bootstrap/cache

# Clear any previously cached configuration, routes, or views.
echo "Clearing application caches..."
php artisan optimize:clear

# Run database migrations.
echo "Running database migrations..."
php artisan migrate --force

# Start PHP-FPM in the background.
echo "Starting PHP-FPM..."
/usr/local/bin/php-fpm &

# Start Nginx in the foreground.
echo "Starting Nginx..."
nginx -g "daemon off;"