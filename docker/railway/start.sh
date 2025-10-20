#!/bin/bash

# Dynamically create .env file from Railway's environment variables
cat <<EOF > .env
APP_NAME=Laravel
APP_ENV=production
APP_KEY=${APP_KEY}
APP_DEBUG=false
APP_URL=https://${RAILWAY_STATIC_URL}

LOG_CHANNEL=stderr

DB_CONNECTION=mysql
DB_HOST=${MYSQLHOST}
DB_PORT=${MYSQLPORT}
DB_DATABASE=${MYSQLDATABASE}
DB_USERNAME=${MYSQLUSER}
DB_PASSWORD=${MYSQLPASSWORD}

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync
EOF

# Now that .env is created, run the necessary artisan commands
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force

# Start PHP-FPM in the background
/usr/local/bin/php-fpm &

# Start Nginx in the foreground
nginx -g "daemon off;"