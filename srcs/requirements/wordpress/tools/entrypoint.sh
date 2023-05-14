#!/usr/bin/env ash

sed -i -e "s/database_name_here/$DB_NAME/" -e "s/username_here/$DB_USER/" -e "s/password_here/$DB_PASSWORD/" -e "s/localhost/$DB_HOST/" /var/www/html/wp-config.php

# Wait until mysql is up
until wp db check --path="/var/www/html"; do echo waiting for MariaDB; sleep 2; done

# If wordpress is not installed, install it
if ! $(wp core is-installed --path="/var/www/html"); then
	wp core install --path="/var/www/html" --url="https://$WORDPRESS_DOMAIN" --title="$WORDPRESS_SITE_TITLE" --admin_email="$WORDPRESS_ADMIN_EMAIL" --admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --skip-email
	wp user create "$WORDPRESS_EDITOR" "$WORDPRESS_EDITOR_EMAIL" --user_pass="$WORDPRESS_EDITOR_PASSWORD" --role="editor" --path="/var/www/html"
	wp plugin install --path="/var/www/html" redis-cache --activate
	wp config set WP_REDIS_HOST redis --path="/var/www/html"
	wp config set WP_REDIS_PORT 6379 --raw --path="/var/www/html"
	wp redis enable --path="/var/www/html"
fi

exec /usr/sbin/php-fpm -F
